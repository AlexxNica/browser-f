// |reftest| error:SyntaxError
// This file was procedurally generated from the following sources:
// - src/function-forms/dflt-params-rest.case
// - src/function-forms/syntax/async-func-expr-nameless.template
/*---
description: RestParameter does not support an initializer (async function nameless expression)
esid: sec-async-function-definitions
features: [default-parameters]
flags: [generated]
negative:
  phase: early
  type: SyntaxError
info: |
    14.6 Async Function Definitions

    AsyncFunctionExpression :
      async function ( FormalParameters ) { AsyncFunctionBody }

    14.1 Function Definitions

    Syntax

    FunctionRestParameter[Yield] :

      BindingRestElement[?Yield]

    13.3.3 Destructuring Binding Patterns

    Syntax

    BindingRestElement[Yield] :

      ...BindingIdentifier[?Yield]
      ...BindingPattern[?Yield]

---*/


(async function(...x = []) {
  
});
