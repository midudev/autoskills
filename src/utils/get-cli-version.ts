export async function getCliVersion() {
  const { default: cliPkg } = await import(
    "../../packages/autoskills/package.json",
    { with: { type: "json" } }
  );
  const cliVersion = cliPkg.version;

  return { cliVersion }
}