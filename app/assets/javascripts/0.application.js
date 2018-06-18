(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[0],{

/***/ "./app/javascript/vuex/modules/event.js":
/*!**********************************************!*\
  !*** ./app/javascript/vuex/modules/event.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nexports.default = {\n  state: {\n    selectedHistoryId: null\n  },\n\n  mutations: {\n    selectHistory: function selectHistory(state, id) {\n      state.selectedHistoryId = id;\n    }\n  },\n\n  actions: {\n    selectHistory: function selectHistory(_ref, id) {\n      var commit = _ref.commit;\n\n      context.commit('selectHistory', id);\n    }\n  }\n};\n\n//# sourceURL=webpack:///./app/javascript/vuex/modules/event.js?");

/***/ })

}]);