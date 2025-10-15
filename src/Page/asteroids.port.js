/**
 * Register the JS implementation of the ELM ports for the Asteroids page.
 *
 * Intercept keyboard events in capture phase to:
 * 1. Prevent default browser behavior (scrolling) when board has focus
 * 2. Block events from reaching Elm when board doesn't have focus
 */
const registerPorts = app => {
  const keysToPrevent = new Set(['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight', ' ', 'Spacebar']);
  let activeBoard = null;
  let boardCleanup = () => {};
  let globalAbort = null;

  const attachGlobal = () => {
    if (globalAbort) return;
    globalAbort = new AbortController();
    const { signal } = globalAbort;

    const onKeyDown = e => {
      if (!activeBoard) return;
      const hasFocus = document.activeElement === activeBoard;
      if (keysToPrevent.has(e.key)) {
        if (hasFocus) e.preventDefault();
        else e.stopPropagation();
      }
    };

    const onKeyUp = e => {
      if (!activeBoard) return;
      const hasFocus = document.activeElement === activeBoard;
      if (keysToPrevent.has(e.key) && !hasFocus) e.stopPropagation();
    };

    document.addEventListener('keydown', onKeyDown, { capture: true, signal });
    document.addEventListener('keyup', onKeyUp, { capture: true, signal });
  };

  app.ports.preventDefaultKeys.subscribe(() => {
    attachGlobal();

    boardCleanup();
    activeBoard = null;

    const svg = document.querySelector('svg.world');
    if (!svg) {
      boardCleanup = () => {};
      return;
    }

    const board = svg.closest('.box');
    if (!board) {
      boardCleanup = () => {};
      return;
    }

    if (!board.hasAttribute('tabindex')) board.setAttribute('tabindex', '0');

    const focusBoard = () => {
      if (document.activeElement !== board) {
        try {
          board.focus({ preventScroll: true });
        } catch {
          board.focus();
        }
      }
    };
    const onFocus = () => {
      activeBoard = board;
    };
    const onBlur = () => {
      if (activeBoard === board) activeBoard = null;
    };
    const onPointerDown = () => focusBoard();
    const onKeyDownBoard = e => {
      if (e.key === 'Escape') board.blur();
    };

    board.addEventListener('focus', onFocus);
    board.addEventListener('blur', onBlur);
    board.addEventListener('pointerdown', onPointerDown);
    board.addEventListener('keydown', onKeyDownBoard);

    focusBoard();
    if (document.activeElement === board) activeBoard = board;

    boardCleanup = () => {
      board.removeEventListener('focus', onFocus);
      board.removeEventListener('blur', onBlur);
      board.removeEventListener('pointerdown', onPointerDown);
      board.removeEventListener('keydown', onKeyDownBoard);
      if (activeBoard === board) activeBoard = null;
    };
  });

  return () => {
    boardCleanup();
    activeBoard = null;
    if (globalAbort) {
      globalAbort.abort();
      globalAbort = null;
    }
  };
};

export { registerPorts };
