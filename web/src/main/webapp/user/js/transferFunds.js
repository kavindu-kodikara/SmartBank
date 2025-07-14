document.getElementById("fromAccount").addEventListener('change', function() {
    const fromAccount = document.getElementById("fromAccount");
    const toAccount = document.getElementById("toAccount");
    const selectedValue = fromAccount.value;

    toAccount.innerHTML = '<option value="" selected disabled>Select an account</option>';

    for (let i = 0; i < fromAccount.options.length; i++) {
        const option = fromAccount.options[i];

        if (option.value === selectedValue || option.value === "") continue;

        const newOption = option.cloneNode(true);
        toAccount.appendChild(newOption);
    }
})

let isScheduled = false;

document.getElementById("transferBtn").addEventListener('click', function() {

    const internalTransfer = document.getElementById("internalTransfer");
    const externalTransfer = document.getElementById("externalTransfer");
    const transferNow = document.getElementById("transferNow");
    const transferLater = document.getElementById("transferLater");

    if(transferLater.checked) {
       isScheduled = true;
    }else if (transferNow.checked) {
        isScheduled = false;
    }

    if(internalTransfer.checked) {
        internalTransferFunction();
    }else if(externalTransfer.checked) {
        externalTransferFunction();
    }



})

async function internalTransferFunction() {

    const fromAccount = document.getElementById("fromAccount").value;
    const toAccount = document.getElementById("toAccount").value;
    const amount = document.getElementById("amount").value;
    const description = document.getElementById("description").value;

    if(fromAccount == 0){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please select from account",
        })
        return;
    }

    if(toAccount == 0){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please select to account",
        })
        return;
    }

    if(amount == "" || amount <= 10){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter valid amount",
        })
        return;
    }

    if(description == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter description",
        })
        return;
    }



    const responce = await fetch("http://localhost:8080/SmartBank/internalTransfer", {
        method: "POST",
        body: JSON.stringify({
            fromAccount: fromAccount,
            toAccount: toAccount,
            amount: amount,
            description: description,
        }),
        headers: {
            "Content-Type": "application/json",
        }
    });

    if(responce.ok){
        const json = await responce.json();
        console.log(json);

        if(json.success){
            Swal.fire({
                icon: "success",
                title: "Success",
                text: "Transaction successful!",
                timer: 1500,
                showConfirmButton: false
            }).then(() => {
                window.location.reload();
            });
        }else{
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: json.message,
            })
        }
    }

}

async function externalTransferFunction() {

    const fromAccount = document.getElementById("fromAccount").value;
    const toAccount = document.getElementById("accountNumber").value;
    const recipientName = document.getElementById("recipientName").value;
    const amount = document.getElementById("amount").value;
    const description = document.getElementById("description").value;
    const transferDate = document.getElementById("transferDate").value;
    const transferTime = document.getElementById("transferTime").value;

    if(fromAccount == 0){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please select from account",
        })
        return;
    }

    if(toAccount == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter to account",
        })
        return;
    }

    if(recipientName == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter recipient name",
        })
        return;
    }

    if(amount == "" || amount <= 10){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter valid amount",
        })
        return;
    }

    if(description == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter description",
        })
        return;
    }

    if(isScheduled){
        if(transferDate == ""){
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Please enter transferDate",
            })
            return;
        }

        if(transferTime == ""){
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "Please enter transferTime",
            })
            return;
        }
    }

    const responce = await fetch("http://localhost:8080/SmartBank" + (isScheduled ? "/scheduled/externalTransfer" : "/externalTransfer"), {
        method: "POST",
        body: JSON.stringify({
            fromAccount: fromAccount,
            toAccount: toAccount,
            recipientName: recipientName,
            amount: amount,
            description: description,
            transferDate: transferDate,
            transferTime: transferTime,
        }),
        headers: {
            "Content-Type": "application/json",
        }
    });

    if(responce.ok){
        const json = await responce.json();
        console.log(json);

        if(json.success){
            Swal.fire({
                icon: "success",
                title: "Success",
                text: "Transaction successful!",
                timer: 1500,
                showConfirmButton: false
            }).then(() => {
                window.location.reload();
            });
        }else{
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: json.message,
            })
        }
    }

}


document.getElementById('sidebarToggle').addEventListener('click', function() {
    document.getElementById('sidebar').classList.toggle('show');
});

// Transfer type toggle
const internalTransfer = document.getElementById('internalTransfer');
const externalTransfer = document.getElementById('externalTransfer');
const internalRecipientSection = document.getElementById('internalRecipientSection');
const externalRecipientSection = document.getElementById('externalRecipientSection');

const scheduleTransferBtn = document.getElementById("scheduleTransferBtn");

internalTransfer.addEventListener('change', function() {
    if (this.checked) {
        internalRecipientSection.classList.remove('d-none');
        externalRecipientSection.classList.add('d-none');
        scheduleTransferBtn.classList.replace("d-block",'d-none');
    }
});

externalTransfer.addEventListener('change', function() {
    if (this.checked) {
        internalRecipientSection.classList.add('d-none');
        externalRecipientSection.classList.remove('d-none');
        scheduleTransferBtn.classList.replace('d-none',"d-block");
    }
});

// Schedule options toggle
const transferNow = document.getElementById('transferNow');
const transferLater = document.getElementById('transferLater');
const scheduleDateSection = document.getElementById('scheduleDateSection');

transferNow.addEventListener('change', function() {
    if (this.checked) {
        scheduleDateSection.classList.add('d-none');
    }
});

transferLater.addEventListener('change', function() {
    if (this.checked) {
        scheduleDateSection.classList.remove('d-none');
        // Set min date to tomorrow
        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);
        const minDate = tomorrow.toISOString().split('T')[0];
        document.getElementById('transferDate').min = minDate;
    }
});

// Form submission
document.getElementById('transferForm').addEventListener('submit', function(e) {
    e.preventDefault();
    // Here you would normally handle the form submission
    alert('Transfer submitted successfully!');
    // Reset form
    this.reset();
    internalRecipientSection.classList.remove('d-none');
    externalRecipientSection.classList.add('d-none');
    scheduleDateSection.classList.add('d-none');
});

// Add animation to form elements
const formElements = document.querySelectorAll('.transfer-form .form-control, .transfer-form .form-select, .transfer-form .form-check-input');
formElements.forEach((element, index) => {
    element.style.opacity = '0';
    element.style.transform = 'translateY(10px)';
    element.style.transition = `all 0.3s ease ${index * 0.05}s`;

    setTimeout(() => {
        element.style.opacity = '1';
        element.style.transform = 'translateY(0)';
    }, 100);
});

