$(document).ready(function () {
    $('#expiry').on('input', function () {
        let val = $(this).val().replace(/[^\d]/g, '');

        if (val.length >= 3) {
            val = val.substring(0, 2) + '/' + val.substring(2, 4);
        }
        $(this).val(val);
    });

    $('#paymentForm').on('submit', function (e) {
        var cardNumber = $('#cardNumber').val().trim();
        var expiry = $('#expiry').val().trim();
        var cvv = $('#cvv').val().trim();

        // Validate card number
        if (!/^\d{16}$/.test(cardNumber)) {
            alert('Card number must be 16 digits.');
            e.preventDefault();
            return;
        }

        // Validate expiry in MM/YY
        if (!/^\d{2}\/\d{2}$/.test(expiry)) {
            alert('Expiry must be in MM/YY format.');
            e.preventDefault();
            return;
        }

        let [month, year] = expiry.split('/').map(Number);
        if (month < 1 || month > 12) {
            alert('Invalid expiry month.');
            e.preventDefault();
            return;
        }

        let today = new Date();
        let expiryDate = new Date(2000 + year, month - 1);
        let currentMonth = new Date(today.getFullYear(), today.getMonth());

        if (expiryDate < currentMonth) {
            alert('Expiry date must be in the future.');
            e.preventDefault();
            return;
        }

        // Validate CVV
        if (!/^\d{3,4}$/.test(cvv)) {
            alert('CVV must be 3 or 4 digits.');
            e.preventDefault();
            return;
        }
    });
});
