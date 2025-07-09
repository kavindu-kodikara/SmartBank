document.getElementById('loginBtn').addEventListener('click', async function(e) {

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if(username == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter your username",
        })
        return;
    }

    if(password == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter your password",
        })
        return;
    }

    const responce = await fetch("http://localhost:8080/SmartBank/login", {
        method: "POST",
        body: JSON.stringify({
            username: username,
            password: password,
        }),
        headers: {
            "Content-Type": "application/json",
        }
    });

    if(responce.ok){
        const json = await responce.json();
        console.log(json);

        if(json){
            document.getElementById('step1').classList.remove('active');
            document.getElementById('step2').classList.add('active');
            document.querySelector('.verification-code input').focus();
        }else{
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Invalid username or password",
            })
        }
    }


});

document.getElementById('verifyCode').addEventListener('click', async function() {

    const code = getVerificationCode();

    console.log(code);

    if(code == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter your OTP Code",
        })
        return;
    }

    const responce = await fetch("http://localhost:8080/SmartBank/verifyOTP", {
        method: "POST",
        body: JSON.stringify({
            code: code,
        }),
        headers: {
            "Content-Type": "application/json",
        }
    });

    if(responce.ok){
        const json = await responce.json();
        console.log(json);

        if(json.success){
            window.location = json.redirect;
        }else{
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Invalid OTP Code",
            })
        }
    }

});

// verification code input
const codeInputs = document.querySelectorAll('.verification-code input');
codeInputs.forEach((input, index) => {
    input.addEventListener('input', function(e) {
        if (this.value.length === 1) {
            if (index < codeInputs.length - 1) {
                codeInputs[index + 1].focus();
            } else {
                document.getElementById('verifyCode').click();
            }
        }
    });

    input.addEventListener('keydown', function(e) {
        if (e.key === 'Backspace' && this.value.length === 0 && index > 0) {
            codeInputs[index - 1].focus();
        }
    });
});

function getVerificationCode() {
    let code = '';
    codeInputs.forEach(input => {
        code += input.value;
    });
    return code;
}



