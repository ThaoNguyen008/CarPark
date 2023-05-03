(() => {
  'use strict';
  const forms = document.querySelectorAll('.needs-validation');

  Array.prototype.slice.call(forms).forEach((form) => {
      form.addEventListener('submit', (event) => {
          if (!form.checkValidity()) {
              event.preventDefault();
              event.stopPropagation();
          }
          form.classList.add('was-validated');
      }, false);
  });
})();

 // let dob = document.querySelector("#inputDate");
 //
 //        console.log("dob");
 //       let dob_error = document.querySelector(".dob_error");
 //
 //        if (getAge(dob) < 18) {
 //            console.log(dob);
 //            dob_error.innerHTML = "DOB is incorrect";
 //
 //
 //        }
 //
 //
 //    function getAge(dob) {
 //        let dob1 = new Date(dob).getTime();
 //        let now = new Date().getTime();
 //        return (now - dob1) / 31556952000;
 //    }

