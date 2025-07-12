document.addEventListener('DOMContentLoaded', function() {

    const togglePassword = document.getElementById('togglePassword');
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');

    togglePassword.addEventListener('click', function() {
        const type = newPassword.getAttribute('type') === 'password' ? 'text' : 'password';
        newPassword.setAttribute('type', type);
        confirmPassword.setAttribute('type', type);
        this.querySelector('i').classList.toggle('fa-eye');
        this.querySelector('i').classList.toggle('fa-eye-slash');
    });

    // Password strength checker
    newPassword.addEventListener('input', function() {
        checkPasswordMatch();
    });

    confirmPassword.addEventListener('input', checkPasswordMatch);


    function checkPasswordMatch() {
        const passwordMatch = document.getElementById('passwordMatch');
        if (newPassword.value && confirmPassword.value) {
            if (newPassword.value === confirmPassword.value) {
                passwordMatch.style.display = 'none';
            } else {
                passwordMatch.style.display = 'block';
            }
        } else {
            passwordMatch.style.display = 'none';
        }
    }


    document.getElementById('createAccountBtn').addEventListener('click', async function() {

        const username = document.getElementById('newUsername').value;
        const password = document.getElementById('newPassword').value;
        const confirmPass = document.getElementById('confirmPassword').value;
        const termsChecked = document.getElementById('termsAgreement').checked;

        if (!username || username.length < 3 || username.length > 20) {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Username',
                text: 'Username must be 3-20 characters long',
            });
            return;
        }



        if (!password) {
            Swal.fire({
                icon: 'error',
                title: 'Password Required',
                text: 'Please create a password',
            });
            return;
        }

        if (password !== confirmPass) {
            Swal.fire({
                icon: 'error',
                title: 'Passwords Don\'t Match',
                text: 'Please make sure both passwords match',
            });
            return;
        }

        if (!termsChecked) {
            Swal.fire({
                icon: 'error',
                title: 'Agreement Required',
                text: 'You must agree to the Terms of Service and Privacy Policy',
            });
            return;
        }

        // If all validations pass, proceed to verification step

        const urlParams = new URLSearchParams(window.location.search);
        const userId = urlParams.get("token");

        const response = await fetch("http://localhost:8080/SmartBank/createUsername", {
            method: "POST",
            body: JSON.stringify({
                username: username,
                password: password,
                id: userId
            }),
            headers: {
                "Content-Type": "application/json",
            }
        });

        if(response.ok){
            const json = await response.json();
            console.log(json);

            if(json){
                document.getElementById('step1').classList.remove('active');
                document.getElementById('step3').classList.add('active');
            }else{
                Swal.fire({
                    icon: "error",
                    title: "Oops...",
                    text: "Something went wrong",
                })
            }
        }


    });


    // Go to dashboard button
    document.getElementById('goToDashboard').addEventListener('click', function() {
        Swal.fire({
            icon: 'success',
            title: 'Welcome to Smart Bank!',
            text: 'Redirecting to your dashboard...',
            timer: 1500,
            showConfirmButton: false
        }).then(() => {
            window.location.href = '/SmartBank';
        });
    });
});