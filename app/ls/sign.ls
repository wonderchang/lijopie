
!function login
  modal = $ \<div> .add-class \ui .add-class \modal .css \font-family, \微軟正黑體
  modal.append($ \<i> .add-class \close .add-class \icon)
  modal.append($ \<div> .add-class \header .text \登入)
  content = $ \<div> .add-class \content .append-to modal
  form = $ \<div> .add-class \ui .add-class \segment .add-class \form .append-to content
  un-field = $ \<div> .add-class \field .append-to form
  pw-field = $ \<div> .add-class \field .append-to form
  un-field.append($ \<label> .text \帳號)
  un-field.append($ \<input> .attr \type, \text .attr \placeholder, \帳號)
  pw-field.append($ \<label> .text \密碼)
  pw-field.append($ \<input> .attr \type, \password .attr \placeholder, \密碼)
  actions = $ \<div> .add-class \actions .append-to modal
  actions.append($ \<button> .add-class \ui .add-class \button .add-class \blue .text \登入)
  actions.append($ \<button> .add-class \ui .add-class \button .add-class \teal .text \我要註冊)
  $ \body .append modal
  $ '.ui.modal' .modal \show

!function signup
  console.log \wef
