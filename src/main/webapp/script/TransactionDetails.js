document.addEventListener('DOMContentLoaded', function() {
    // Add any interactive functionality here if needed
    
    // Example: Confirm before payment
    const payButtons = document.querySelectorAll('.pay-button');
    payButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to proceed to payment?')) {
                e.preventDefault();
            }
        });
    });
    
    // You can add more interactive features as needed
});