$(document).ready(function() {
    // Handle form submission
    $('#complaintForm').submit(function(e) {
        e.preventDefault();
        
        // Show loading state
        $('.submit-btn').html('<i class="fas fa-spinner fa-spin"></i> Submitting...');
        $('.submit-btn').prop('disabled', true);
        
        // Submit form via AJAX
        $.ajax({
            type: 'POST',
            url: 'ComplaintController',
            data: $(this).serialize(),
            success: function(response) {
                if (response === 'success') {
                    $('#successModal').css('display', 'flex');
                    // Reset form
                    $('#complaintForm')[0].reset();
                } else {
                    $('#errorModal').css('display', 'flex');
                }
            },
            error: function() {
                $('#errorModal').css('display', 'flex');
            },
            complete: function() {
                // Reset button state
                $('.submit-btn').html('<i class="fas fa-paper-plane"></i> Submit Complaint');
                $('.submit-btn').prop('disabled', false);
            }
        });
    });
});

function closeModal() {
    $('.modal').css('display', 'none');
    
    // Redirect to dashboard after successful submission if needed
    if ($('#successModal').css('display') === 'flex') {
        setTimeout(function() {
            window.location.href = 'userDashboard.jsp';
        }, 2000);
    }
}