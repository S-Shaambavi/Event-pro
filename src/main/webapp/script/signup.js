function validateForm() {
    let firstName = document.forms["signupForm"]["firstName"].value;
    let lastName = document.forms["signupForm"]["lastName"].value;
    let dob = document.forms["signupForm"]["dob"].value;
    let phone = document.forms["signupForm"]["phone"].value;
    let email = document.forms["signupForm"]["email"].value;
    let password = document.forms["signupForm"]["password"].value;
    let confirmPassword = document.forms["signupForm"]["confirmPassword"].value;

    if (!firstName || !lastName || !dob || !phone || !email || !password || !confirmPassword) {
        alert("All fields must be filled out");
        return false;
    }

    let phoneRegex = /^\d{10}$/;
    if (!phoneRegex.test(phone)) {
        alert("Phone number must be exactly 10 digits");
        return false;
    }

    let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("Invalid email format");
        return false;
    }

    if (password !== confirmPassword) {
        alert("Passwords do not match");
        return false;
    }

    let genderSelected = document.querySelector('input[name="gender"]:checked');
    if (!genderSelected) {
        alert("Please select a gender");
        return false;
    }

    let birthDate = new Date(dob);
    let today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    let monthDiff = today.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    if (age < 18) {
        alert("You must be at least 18 years old to sign up");
        return false;
    }

    return true;
}