// Helper validation functions
function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}

function validatePhone(phone) {
    var re = /^[0-9]{10}$/;
    return re.test(phone);
}

function validateNumber(value) {
    return !isNaN(value) && Number(value) >= 0;
}

// Main validation function
function validateForm(event) {
    var form = event.target;
    var inputs = form.querySelectorAll("input, select, textarea");

    for (var i = 0; i < inputs.length; i++) {
        var input = inputs[i];
        var id = input.id;
        var value = input.value.trim();

        if (input.hasAttribute("required") && value === "") {
            alert("Please fill out the required field: " + id);
            input.focus();
            event.preventDefault();
            return false;
        }

        if (id.includes("email") && !validateEmail(value)) {
            alert("Please enter a valid email address.");
            input.focus();
            event.preventDefault();
            return false;
        }

        if (id.includes("phone") && !validatePhone(value)) {
            alert("Please enter a valid 10-digit phone number.");
            input.focus();
            event.preventDefault();
            return false;
        }

        if ((input.type === "number" || id.includes("count") || id.includes("price") || id.includes("cost") || id.includes("capacity")) && !validateNumber(value)) {
            alert("Please enter a valid non-negative number for: " + id);
            input.focus();
            event.preventDefault();
            return false;
        }
    }

    // If all checks pass
    return true;
}

// Attach validation to all forms
window.onload = function () {
    var forms = document.querySelectorAll("form");
    for (var i = 0; i < forms.length; i++) {
        forms[i].addEventListener("submit", validateForm);
    }
};
