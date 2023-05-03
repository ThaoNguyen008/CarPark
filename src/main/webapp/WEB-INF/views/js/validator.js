// function getDestinationError() {
//   const destinationElement = document.getElementById('inputDestination');
//   if (!destinationElement) return;

//   // required
//   if (destinationElement.validity.valueMissing) return 'Please enter destination.';

//   return '';
// }

// function setTextContent(parent, selector, text) {
//     if (!parent) return;

//     const element = parent.querySelector(selector);
//     if (element) element.textContent = text;
//     element.style.display = 'block';
// }

// function validateTripForm(formValues) {
//     // get errors
//     const errors = {
//         // key : value
//       destination: getDestinationError(),//key owr ddaay 
//     };
  
//     // set errors
//     for (const key in errors) {
//       const element = document.querySelector(`[name="${key}"]`);
//       if (element) {
//         element.setCustomValidity(errors[key]);
//         // element.textContent = errors[key];
//         setTextContent(element.parentElement, '.invalid-feedback', errors[key]);
//       }
//     }
//   }

// function submitTripForm(formValues){
//     validateTripForm();
// }

// (() => {
//     const btnAddTrip = document.getElementById('btnAddTrip');
//     if (btnAddTrip) {
//         btnAddTrip.addEventListener('click', validateTripForm)
//     } 
//     // getDestinationError();
// })()