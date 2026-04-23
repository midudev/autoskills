import { featuredSponsors, type Sponsor } from "@/constants/featured-sponsors";

export async function fetchSponsors() {
  let sponsors: Sponsor[] = featuredSponsors;
  try {
    const token = import.meta.env.GITHUB_TOKEN;
    if (token) {
      const res = await fetch("https://api.github.com/graphql", {
        method: "POST",
        headers: {
          Authorization: `bearer ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          query: `{
          user(login: "midudev") {
            sponsorshipsAsMaintainer(first: 100, activeOnly: true) {
              nodes {
                sponsorEntity {
                  ... on User { login databaseId }
                  ... on Organization { login databaseId }
                }
              }
            }
          }
        }`,
        }),
      });
      const data = await res.json();
      const live = (data?.data?.user?.sponsorshipsAsMaintainer?.nodes ?? [])
        .map((n: any) => ({
          login: n.sponsorEntity?.login,
          id: n.sponsorEntity?.databaseId,
        }))
        .filter((s: Sponsor) => s.login && s.id);
      if (live.length > 0) sponsors = live;
    }
  } catch {
    // Falls back to featuredSponsors
  }

  return { sponsors }
}
