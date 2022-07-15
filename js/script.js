object["indexForInputNumber"] = 0;
showQuestions(object);
const selectForm = document.getElementById("form");
const sendForm = document.getElementById("sendForm");
const errorText = document.getElementById("errorText");
const numberOfQuestions = document.getElementsByClassName("item").length - 1;
const percentageOfProgressQuestion =
  CalculationOfThePercentageQuestion(numberOfQuestions);
let percentage = 0;
const progressBar = document.getElementById("progressBar__percentage");
const percentageInnerText = document.getElementById("innerPercentage");
writeTheNumberOfQuestions(numberOfQuestions);

//==========================================================================================================
selectForm.addEventListener("submit", (event) => {
  event.preventDefault();
});
//==========================================================================================================
//=================================== Une fois le formulaire terminé et envoyé =============================
//==========================================================================================================
//Empeche l'envoie du formulaire en appuyant sur un bouton
sendForm.addEventListener("click", (event) => {
  event.preventDefault();

  let check = checkform();
  if (check == true) {
    const form = createObject(object);

    let jsonFormulaire = JSON.stringify(form);
    let URL = "index.php?controller=answer&task=resultOfTheForm";
    let formData = new FormData();
    formData.append("formulaire", jsonFormulaire);

    fetch(URL, {
      body: formData,
      method: "post",
    })
      .then(function (result) {
        return result.json();
      })
      .then(function (data) {
        let destructForm = document.getElementById("index");
        destructForm.remove();
        document.getElementById("result").style.display = "unset";
        showWinner(data);
      });
  }
});

//==========================================================
//==========================================================
//==========================================================
function writeTheNumberOfQuestions(numberOfQuestions) {
  document.getElementById("numberQuestions").innerText = numberOfQuestions;
}

//==========================================================
//==========================================================
//==========================================================
function CalculationOfThePercentageQuestion(numberOfQuestions) {
  const percentageOfProgressQuestion = (100 / numberOfQuestions).toFixed(0);
  return percentageOfProgressQuestion;
}

//==========================================================
//==========================================================
//==========================================================
/**
 * @showQuestions prend en paramètre un objet @object
 * {
 *      0: {
 *          question: "........."
 *          answer: ['...', '...', '....', '...']
 *          id: ['...', '...', '...', ...]
 *      },
 * }
 * elle permet de faire apparaitre les question avec ces réponse dans un formulaire.
 */
//==========================================================
function showQuestions(object) {
  const toPlaceQuestion = document.getElementById("position");
  const QuestionNodeParent = toPlaceQuestion.parentNode;

  for (const keyIndex in object["question"]) {
    let createDivItem = document.createElement("div");
    createDivItem.className = "item not-yet";

    let createContainer = document.createElement("div");
    createContainer.id = "question__" + keyIndex;

    let createQuestion = document.createElement("h2");
    createQuestion.innerText = object["question"][keyIndex]["label"];

    createDivItem.appendChild(createContainer);
    createContainer.appendChild(createQuestion);

    showAnswer(object, keyIndex, createContainer);

    QuestionNodeParent.insertBefore(createDivItem, toPlaceQuestion);
  }
}

//==========================================================
//==========================================================
//==========================================================
/**
 * @showAnswer
 * Prend en paramètre @object , @keyIndex , @createContainer
 */
//==========================================================
function showAnswer(object, keyIndex, createContainer) {
  let countAnswer = Object.keys(object["question"][keyIndex]["answer"]).length;

  let createUl = document.createElement("ul");

  for (let i = 0; i < countAnswer; i++) {
    let createLI = document.createElement("li");
    createLI.className = "radio";

    let createInput = document.createElement("input");
    createInput.type = object["question"][keyIndex]["answer"][i]["type"];
    createInput.value = object["question"][keyIndex]["answer"][i]["id"];
    createInput.name = "answer_" + keyIndex;
    createInput.className = "answer_" + keyIndex;
    createInput.id = "radio-" + object["indexForInputNumber"];

    let createAnswer = document.createElement("label");
    createAnswer.innerText = object["question"][keyIndex]["answer"][i]["label"];
    createAnswer.setAttribute("for", `radio-${object["indexForInputNumber"]}`);
    createAnswer.className = "radio-label";

    //mettre la l'input dans la balise LI
    createLI.appendChild(createInput);

    //mettre la réponse à la suite dans la balise LI
    createLI.appendChild(createAnswer);

    //mettre le LI dans la balise UL
    createUl.appendChild(createLI);

    object["indexForInputNumber"]++;
  }
  //mettre le LI dans la DIV
  createContainer.appendChild(createUl);

  if (object["question"][keyIndex]["answer"][0]["type"] == "checkbox") {
    let createButtonValider = document.createElement("button");
    createButtonValider.className = "valider";
    createButtonValider.id = "buttonValider";
    createButtonValider.value = "answer_" + keyIndex;
    createButtonValider.innerText = "Valider";
    createContainer.appendChild(createButtonValider);
  }

  let createButtonBack = document.createElement("button");
  createButtonBack.className = "back";
  createButtonBack.innerText = "\u27a4";

  if (keyIndex == 1) {
    createButtonBack.disabled = "false";
  }
  createContainer.appendChild(createButtonBack);

  let createButtonNext = document.createElement("button");
  createButtonNext.className = "next";
  createButtonNext.innerText = "\u27a4";
  createButtonNext.value = "answer_" + keyIndex;
  createContainer.appendChild(createButtonNext);
}

/**
 * ====================================================================
 * @showWinner prend en paramètre un objet @object
 * Permet d'afficher la solution gagnante
 * ====================================================================
 */
function showWinner(object) {
  let selectLogoFirst = document.getElementById("first");
  selectLogoFirst.src = object["winner"]["podium"]["first"]["logo_url"];

  let selectLogoSecond = document.getElementById("second");
  selectLogoSecond.src = object["winner"]["podium"]["second"]["logo_url"];

  let selectLogoThird = document.getElementById("third");
  selectLogoThird.src = object["winner"]["podium"]["third"]["logo_url"];

  let selectContenaireDescription = document.getElementById("description");
  selectContenaireDescription.innerHTML =
    object["winner"]["podium"]["first"]["description"];

  //mettre active la cible result
  document.getElementById("result").classList.toggle("active");
}

//==========================================================
//==========================================================
//==========================================================
/**
 * ====================================================================
 * @createObject prend en paramètre un objet @object
 * Crée la mise en forme de l'objet
 * ====================================================================
 */
function createObject(object) {
  let answerArray = new Array();
  for (const responseNumber in object["question"]) {
    //prendre la valeur de la réponse et la mettre dans le tableau
    const possibleAnswer = document.getElementsByName(
      "answer_" + responseNumber
    );
    const arrayAnswerCheckbox = new Array();
    if (object["question"][responseNumber]["answer"][0]["type"] == "radio") {
      answerArray.push(
        document.querySelector(`input[name="answer_${responseNumber}"]:checked`)
          .value
      );
    } else {
      for (
        let indexkeyAnswer = 0;
        indexkeyAnswer < possibleAnswer.length;
        indexkeyAnswer++
      ) {
        if (possibleAnswer[indexkeyAnswer].checked) {
          answerArray.push(possibleAnswer[indexkeyAnswer].value);
        }
      }
    }
  }

  let takeFirstName = document.getElementById("firstName");
  if (takeFirstName !== null) {
    takeFirstName = takeFirstName.value;
  }

  let takeName = document.getElementById("name");
  if (takeName !== null) {
    takeName = takeName.value;
  }

  let takeTelephone = document.getElementById("telephone");
  if (takeTelephone !== null) {
    takeTelephone = takeTelephone.value;
  }

  let takeAssociation = document.getElementById("association");
  if (takeAssociation !== null) {
    takeAssociation = takeAssociation.value;
  }

  let takeMail = document.getElementById("mail");
  if (takeMail !== null) {
    takeMail = takeMail.value;
  }

  //mettre dans un objet les valeurs
  const createObjectFormulaire = {
    answer: answerArray,
    firstName: takeFirstName,
    name: takeName,
    telephone: takeTelephone,
    association: takeAssociation,
    mail: takeMail,
  };

  return createObjectFormulaire;
}

//============================================================
//= Permet de passer à la question suivante si input cliquer =
//============================================================
$("input[type='radio']").click(function () {
  const parent = $(this).closest(".item");
  const next = parent.parent().find(".item.not-yet").first();

  setTimeout(function () {
    parent.toggleClass("done");
    next.toggleClass("not-yet");
    addPercentage();
    deleteErrorText();
  }, 1000);
});

//============================================================
//========== Permet de revenir à la question précédente ======
//============================================================
$(".back").click(function () {
  const parentButton = $(this).closest(".item");
  const prev = parentButton.parent().find(".item.done").last();
  parentButton.toggleClass("not-yet");
  prev.toggleClass("done");
  removePercentage();
  deleteErrorText();
});

//============================================================
//=========== Permet de commencer le questionnaire ===========
//============================================================
$(".runForm").click(function () {
  const parent = $(this).closest(".item");
  const next = parent.parent().find(".item.not-yet").first();
  parent.toggleClass("done");
  next.toggleClass("not-yet");
  document.getElementById("containsPercentageBar").style.visibility = "visible";
  addPercentage();
  deleteErrorText();
  document;
});

//================================================================
//= Permet de passer à la question suivante si input est checked =
//================================================================
$(".next").click(function () {
  let choiceAnswer = $(this).val();
  if ($("input[name=" + choiceAnswer + "]").is(":checked")) {
    const parent = $(this).closest(".item");
    const next = parent.parent().find(".item.not-yet").first();
    parent.toggleClass("done");
    next.toggleClass("not-yet");

    addPercentage();
    deleteErrorText();
  } else {
    errorText.innerText = "cettte question est obligatoire";
  }
});
//====================================================================
//= Permet de passer à la question suivante si input radio est check =
//====================================================================
$(".valider").click(function () {
  let choiceAnswer = $(this).val();
  if ($("input[name=" + choiceAnswer + "]").is(":checked")) {
    const parent = $(this).closest(".item");
    const next = parent.parent().find(".item.not-yet").first();
    parent.toggleClass("done");
    next.toggleClass("not-yet");
    addPercentage();
    deleteErrorText();
  } else {
    errorText.innerText = "cettte question est obligatoire";
  }
});
//============================================================
//= Empêcher d'envoyer le formulaire avec la touche "enter" ==
//============================================================
$(document).ready(function () {
  $("form").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      return false;
    }
  });
});

//==========================================================
//==========================================================
//==========================================================
function addPercentage() {
  percentage = Number(percentage) + Number(percentageOfProgressQuestion);

  if (percentage > 100) {
    percentage = 100;
  }
  progressBar.style.width = percentage + "%";
  percentageInnerText.innerText = percentage + "%";
}

//==========================================================
//==========================================================
//==========================================================
function removePercentage() {
  percentage = Number(percentage) - Number(percentageOfProgressQuestion);
  progressBar.style.width = percentage + "%";
  percentageInnerText.innerText = percentage + "%";
}

//==========================================================
//==========================================================
//==========================================================
function deleteErrorText() {
  errorText.innerText = "";
}
//==========================================================
//==========================================================
//==========================================================
function checkform() {
  let error = document.getElementById("errorForm");

  let takeFirstName = document.getElementById("firstName");
  if (takeFirstName !== null) {
    takeFirstName = takeFirstName.value;
    if (checkFirstName(takeFirstName)) {
    } else {
      error.innerText = "Le prénom n'est pas valide";
      return false;
    }
  }

  let takeName = document.getElementById("name");
  if (takeName !== null) {
    takeName = takeName.value;
    if (checkName(takeName)) {
    } else {
      error.innerText = "Le nom n'est pas valide";
      return false;
    }
  }
  let takeTelephone = document.getElementById("telephone");
  if (takeTelephone !== null) {
    takeTelephone = takeTelephone.value;
    if (checkTelephone(takeTelephone)) {
    } else {
      error.innerText = "Le téléphone n'est pas valide";
      return false;
    }
  }

  let takeAssociation = document.getElementById("association");
  if (takeAssociation !== null) {
    takeAssociation = takeAssociation.value;
    if (checkAssociationName(takeAssociation)) {
    } else {
      error.innerText = "Il manque le nom de l'association";
      return false;
    }
  }

  let takeMail = document.getElementById("mail");
  if (takeMail !== null) {
    takeMail = takeMail.value;
    if (checkMail(takeMail)) {
    } else {
      error.innerText = "Le mail n'est pas valide";
      return false;
    }
  }

  let takeCheck = document.getElementById("check");
  if (takeCheck.checked == false) {
    error.innerText = "Il est obligatoire de cocher la case";
    return false;
  }

  return true;
}

//==========================================================
function checkMail(takeMail) {
  let regexMail =
    /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return regexMail.test(takeMail);
}

//==========================================================
function checkAssociationName(takeAssociation) {
  let regexName = /^[a-zA-Z1-9éèàâäêëûüù'&@\s+]{1,50}$/;
  return regexName.test(takeAssociation);
}
//==========================================================
function checkName(takeName) {
  let regexName = /^[a-zA-Zéèàâäêëûüù\s+]{1,50}$/;
  return regexName.test(takeName);
} //==========================================================
function checkTelephone(takeTelephone) {
  let regexName = /^((\+)\d{1,2}|0)[1-9](\d{2}){4}$/;
  return regexName.test(takeTelephone);
} //==========================================================
function checkFirstName(takeFirstName) {
  let regexName = /^[a-zA-Z1-9éèàâäêëûüù\s+]{1,50}$/;
  return regexName.test(takeFirstName);
}
