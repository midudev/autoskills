const state = {
  snapshot: null,
  view: "installed",
  query: "",
  scope: "all",
  kind: "all",
  drawer: "all",
  cursor: 0,
  marked: new Set(),
  detail: null,
  pane: "body",
  pendingDeleteIds: [],
};

const els = {
  projectName: document.querySelector("#project-name"),
  projectPath: document.querySelector("#project-path"),
  installedCount: document.querySelector("#installed-count"),
  suggestedCount: document.querySelector("#suggested-count"),
  search: document.querySelector("#search"),
  drawer: document.querySelector("#drawer"),
  grid: document.querySelector("#grid"),
  empty: document.querySelector("#empty"),
  status: document.querySelector("#status"),
  sheet: document.querySelector("#sheet"),
  sheetTitle: document.querySelector("#sheet-title"),
  sheetMeta: document.querySelector("#sheet-meta"),
  sheetDesc: document.querySelector("#sheet-desc"),
  sheetPath: document.querySelector("#sheet-path"),
  sheetBody: document.querySelector("#sheet-body"),
  sheetSource: document.querySelector("#sheet-source"),
  sheetFiles: document.querySelector("#sheet-files"),
  confirm: document.querySelector("#confirm"),
  confirmCopy: document.querySelector("#confirm-copy"),
  installNew: document.querySelector("#install-new"),
  installedFilters: document.querySelector("#installed-filters"),
  suggestedFilters: document.querySelector("#suggested-filters"),
};

function setStatus(message) {
  els.status.textContent = message || "";
}

function projectLabel(path) {
  if (!path) return "this project";
  return path.split(/[\\/]/).filter(Boolean).at(-1) || path;
}

function escapeHtml(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

function renderMarkdown(source) {
  const escaped = escapeHtml(source || "");
  return escaped
    .replace(/^### (.+)$/gm, "<h3>$1</h3>")
    .replace(/^## (.+)$/gm, "<h2>$1</h2>")
    .replace(/^# (.+)$/gm, "<h1>$1</h1>")
    .replace(/`([^`]+)`/g, "<code>$1</code>")
    .replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>")
    .replace(/^(?:- |\* )(.+)$/gm, "<li>$1</li>")
    .replace(/(<li>.*<\/li>\n?)+/g, (block) => `<ul>${block}</ul>`)
    .replace(/^(?!<h\d|<ul|<li|<p|<\/)(.+)$/gm, "<p>$1</p>");
}

function visibleItems() {
  if (!state.snapshot) return [];
  if (state.view === "suggested") {
    const q = state.query.trim().toLowerCase();
    return state.snapshot.recommended.filter((item) => {
      if (!q) return true;
      return [item.name, item.skill, item.sources.join(" ")].join(" ").toLowerCase().includes(q);
    });
  }

  const q = state.query.trim().toLowerCase();
  return state.snapshot.installed.filter((item) => {
    if (state.scope !== "all" && item.scope !== state.scope) return false;
    if (state.kind !== "all" && item.kind !== state.kind) return false;
    if (state.drawer !== "all" && `${item.scope}:${item.drawer}` !== state.drawer) return false;
    if (!q) return true;
    return [item.name, item.description, item.path, item.drawer, item.agent]
      .join(" ")
      .toLowerCase()
      .includes(q);
  });
}

function renderDrawerOptions() {
  const current = state.drawer;
  const drawers = state.snapshot?.drawers || [];
  els.drawer.innerHTML =
    `<option value="all">Every drawer</option>` +
    drawers
      .map(
        (drawer) =>
          `<option value="${escapeHtml(drawer.id)}">${escapeHtml(drawer.label)} · ${drawer.scope} (${drawer.count})</option>`,
      )
      .join("");
  els.drawer.value = drawers.some((drawer) => drawer.id === current) ? current : "all";
  state.drawer = els.drawer.value;
}

function cardHtml(item, index) {
  if (state.view === "suggested") {
    return `
      <article class="card" data-index="${index}" data-id="${escapeHtml(item.skill)}" tabindex="0">
        <div class="card-top">
          <span>${escapeHtml(item.sources[0] || "stack")}</span>
          <span>${item.installed ? "already in" : "new"}</span>
        </div>
        <h3>${escapeHtml(item.name)}</h3>
        <p class="desc">${escapeHtml(item.skill)}</p>
        <div class="stamps">
          ${item.installed ? `<span class="stamp">installed</span>` : `<span class="stamp project">suggested</span>`}
          ${item.security?.status === "warning" ? `<span class="stamp warn">security</span>` : ""}
          ${item.security?.status === "info" ? `<span class="stamp">security note</span>` : ""}
        </div>
        ${item.installed ? "" : `<button type="button" class="btn primary" data-install="${escapeHtml(item.skill)}">Install</button>`}
      </article>
    `;
  }

  return `
    <article class="card${state.marked.has(item.id) ? " is-marked" : ""}" data-index="${index}" data-id="${escapeHtml(item.id)}" tabindex="0">
      <div class="card-top">
        <span>${escapeHtml(item.drawer)}</span>
        <span>${escapeHtml(item.kind)}</span>
      </div>
      <h3>${escapeHtml(item.name)}</h3>
      <p class="desc">${escapeHtml(item.description || "No description in frontmatter.")}</p>
      <div class="stamps">
        <span class="stamp ${item.scope}">${item.scope}</span>
        <span class="stamp">${escapeHtml(item.agent)}</span>
        ${item.managed ? `<span class="stamp">autoskills</span>` : ""}
        ${item.broken ? `<span class="stamp warn">broken link</span>` : ""}
      </div>
    </article>
  `;
}

function renderGrid() {
  const items = visibleItems();
  if (state.cursor >= items.length) state.cursor = Math.max(0, items.length - 1);
  els.grid.innerHTML = items.map((item, index) => cardHtml(item, index)).join("");
  els.empty.classList.toggle("is-hidden", items.length > 0);
  const cards = [...els.grid.querySelectorAll(".card")];
  cards.forEach((card, index) => card.classList.toggle("is-active", index === state.cursor));
  els.installedCount.textContent = String(state.snapshot?.installed.length || 0);
  const newCount = (state.snapshot?.recommended || []).filter((item) => !item.installed).length;
  els.suggestedCount.textContent = String(state.snapshot?.recommended.length || 0);
  els.installNew.disabled = newCount === 0;
  els.installNew.textContent = newCount > 0 ? `Install ${newCount} new` : "Install new suggestions";
}

function setView(view) {
  state.view = view;
  state.cursor = 0;
  document.querySelectorAll(".tab").forEach((tab) => {
    const active = tab.dataset.view === view;
    tab.classList.toggle("is-active", active);
    tab.setAttribute("aria-pressed", String(active));
  });
  els.installedFilters.classList.toggle("is-hidden", view !== "installed");
  els.suggestedFilters.classList.toggle("is-hidden", view !== "suggested");
  renderGrid();
}

async function loadSnapshot() {
  setStatus("Reading local drawers…");
  const res = await fetch("/api/snapshot");
  if (!res.ok) throw new Error("Could not read installed skills");
  state.snapshot = await res.json();
  els.projectName.textContent = projectLabel(state.snapshot.projectDir);
  els.projectPath.textContent = state.snapshot.projectDir;
  renderDrawerOptions();
  renderGrid();
  setStatus(
    `${state.snapshot.installed.length} installed · ${state.snapshot.recommended.length} suggested for this stack`,
  );
}

function closeSheet() {
  els.sheet.hidden = true;
  state.detail = null;
}

function showPane(pane) {
  state.pane = pane;
  document.querySelectorAll(".sheet-tabs .chip").forEach((chip) => {
    chip.classList.toggle("is-active", chip.dataset.pane === pane);
  });
  els.sheetBody.classList.toggle("is-hidden", pane !== "body");
  els.sheetSource.classList.toggle("is-hidden", pane !== "source");
  els.sheetFiles.classList.toggle("is-hidden", pane !== "files");
}

async function openDetail(id) {
  const res = await fetch(`/api/skills/${encodeURIComponent(id)}`);
  if (!res.ok) {
    setStatus("Could not open that skill.");
    return;
  }
  const detail = await res.json();
  state.detail = detail;
  els.sheetTitle.textContent = detail.name;
  els.sheetMeta.textContent = `${detail.scope} · ${detail.drawer} · ${detail.kind}`;
  els.sheetDesc.textContent = detail.description || "No description in frontmatter.";
  els.sheetPath.textContent = detail.path;
  els.sheetBody.innerHTML = renderMarkdown(detail.body || "_Empty skill body._");
  els.sheetSource.textContent = detail.body || "";
  els.sheetFiles.innerHTML = (detail.files || [])
    .map(
      (file) =>
        `<li><button type="button" data-file="${escapeHtml(file)}">${escapeHtml(file)}</button></li>`,
    )
    .join("");
  showPane("body");
  els.sheet.hidden = false;
  document.querySelector("#sheet-close").focus();
}

function closeConfirm() {
  els.confirm.hidden = true;
  state.pendingDeleteIds = [];
}

function askDelete(ids) {
  if (!ids.length) return;
  state.pendingDeleteIds = ids;
  els.confirmCopy.textContent = `This permanently removes ${ids.length} skill${ids.length === 1 ? "" : "s"} from disk. There is no undo.`;
  els.confirm.hidden = false;
  document.querySelector("#confirm-ok").focus();
}

async function confirmDelete() {
  const ids = state.pendingDeleteIds;
  closeConfirm();
  if (!ids.length) return;
  setStatus("Deleting…");
  const res = await fetch("/api/remove", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ ids }),
  });
  const result = await res.json();
  if (!res.ok) {
    setStatus(result.error || "Delete failed");
    return;
  }
  state.marked.clear();
  closeSheet();
  await loadSnapshot();
  const failed = result.errors?.length || 0;
  setStatus(
    failed
      ? `Removed ${result.removed.length}, ${failed} failed`
      : `Removed ${result.removed.length} skill${result.removed.length === 1 ? "" : "s"}`,
  );
}

async function installSkills(skills) {
  if (!skills.length) return;
  setStatus(`Installing ${skills.length} skill${skills.length === 1 ? "" : "s"}…`);
  const res = await fetch("/api/install", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ skills, agents: state.snapshot?.agents || [] }),
  });
  const result = await res.json();
  if (!res.ok) {
    setStatus(result.error || "Install failed");
    return;
  }
  await loadSnapshot();
  setStatus(
    result.failed
      ? `Installed ${result.installed}, ${result.failed} failed`
      : `Installed ${result.installed} skill${result.installed === 1 ? "" : "s"}`,
  );
}

function currentId() {
  const items = visibleItems();
  const item = items[state.cursor];
  if (!item) return null;
  return state.view === "suggested" ? item.skill : item.id;
}

function bind() {
  document.querySelectorAll(".tab").forEach((tab) => {
    tab.addEventListener("click", () => setView(tab.dataset.view));
  });

  els.search.addEventListener("input", () => {
    state.query = els.search.value;
    state.cursor = 0;
    renderGrid();
  });

  document.querySelectorAll("input[name=scope]").forEach((input) => {
    input.addEventListener("change", () => {
      if (input.checked) {
        state.scope = input.value;
        state.cursor = 0;
        renderGrid();
      }
    });
  });

  document.querySelectorAll("input[name=kind]").forEach((input) => {
    input.addEventListener("change", () => {
      if (input.checked) {
        state.kind = input.value;
        state.cursor = 0;
        renderGrid();
      }
    });
  });

  els.drawer.addEventListener("change", () => {
    state.drawer = els.drawer.value;
    state.cursor = 0;
    renderGrid();
  });

  els.grid.addEventListener("click", (event) => {
    const install = event.target.closest("[data-install]");
    if (install) {
      event.preventDefault();
      installSkills([install.dataset.install]);
      return;
    }
    const card = event.target.closest(".card");
    if (!card) return;
    state.cursor = Number(card.dataset.index);
    renderGrid();
    if (state.view === "installed") openDetail(card.dataset.id);
  });

  els.installNew.addEventListener("click", () => {
    const skills = (state.snapshot?.recommended || [])
      .filter((item) => !item.installed)
      .map((item) => item.skill);
    installSkills(skills);
  });

  document.querySelector("#sheet-close").addEventListener("click", closeSheet);
  document.querySelector("#sheet-delete").addEventListener("click", () => {
    if (state.detail) askDelete([state.detail.id]);
  });
  document.querySelectorAll(".sheet-tabs .chip").forEach((chip) => {
    chip.addEventListener("click", () => showPane(chip.dataset.pane));
  });
  els.sheetFiles.addEventListener("click", async (event) => {
    const button = event.target.closest("[data-file]");
    if (!button || !state.detail) return;
    const res = await fetch(
      `/api/skills/${encodeURIComponent(state.detail.id)}/file?path=${encodeURIComponent(button.dataset.file)}`,
    );
    if (!res.ok) return;
    const file = await res.json();
    els.sheetSource.textContent = file.content;
    showPane("source");
  });

  document.querySelector("#confirm-cancel").addEventListener("click", closeConfirm);
  document.querySelector("#confirm-ok").addEventListener("click", confirmDelete);
  els.sheet.addEventListener("click", (event) => {
    if (event.target === els.sheet) closeSheet();
  });
  els.confirm.addEventListener("click", (event) => {
    if (event.target === els.confirm) closeConfirm();
  });

  document.addEventListener("keydown", (event) => {
    const typing =
      event.target === els.search ||
      event.target.tagName === "INPUT" ||
      event.target.tagName === "SELECT";
    if (event.key === "Escape") {
      if (!els.confirm.hidden) closeConfirm();
      else if (!els.sheet.hidden) closeSheet();
      else if (typing) els.search.blur();
      return;
    }
    if (event.key === "/" && !typing) {
      event.preventDefault();
      els.search.focus();
      return;
    }
    if (typing) return;
    if (event.key === "1") setView("installed");
    if (event.key === "2") setView("suggested");
    if (event.key === "j") {
      state.cursor = Math.min(visibleItems().length - 1, state.cursor + 1);
      renderGrid();
    }
    if (event.key === "k") {
      state.cursor = Math.max(0, state.cursor - 1);
      renderGrid();
    }
    if (event.key === "Enter" && state.view === "installed") {
      const id = currentId();
      if (id) openDetail(id);
    }
    if (event.key === "x" && state.view === "installed") {
      const id = currentId();
      if (!id) return;
      if (state.marked.has(id)) state.marked.delete(id);
      else state.marked.add(id);
      renderGrid();
    }
    if (event.key === "d" && state.view === "installed") {
      const ids = state.marked.size ? [...state.marked] : currentId() ? [currentId()] : [];
      askDelete(ids);
    }
  });
}

bind();
loadSnapshot().catch((err) => setStatus(err.message));
