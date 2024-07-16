/**
 * Register the JS implementation of the ELM ports.
 *
 * - evalJS: (Elm -> JS) evaluate a string as javascript code.
 * - evalJSResults: (JS -> Elm) string result of the evaluation.
 */
const registerPorts = app => {
  app.ports.evalJS.subscribe(code => {
    let result = '';
    try {
      result = eval(code);
    } catch (err) {
      result = err;
    }

    app.ports.evalJSResults.send(`> ${code}\n${result}`);
  });
};

export { registerPorts };
