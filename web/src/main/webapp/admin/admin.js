document.getElementById('sidebarToggle').addEventListener('click', function() {
    document.getElementById('sidebar').classList.toggle('show');
});

const triggerTabList = [].slice.call(document.querySelectorAll('a[data-bs-toggle="tab"]'))
triggerTabList.forEach(function (triggerEl) {
    const tabTrigger = new bootstrap.Tab(triggerEl)

    triggerEl.addEventListener('click', function (event) {
        event.preventDefault()
        tabTrigger.show()
    })
})

document.getElementById("registerBtn").addEventListener("click", async function (event) {

    const firstName = document.getElementById("firstName").value;
    const lastName = document.getElementById("lastName").value;
    const email = document.getElementById("email").value;
    const mobile = document.getElementById("mobile").value;
    const nic = document.getElementById("nic").value;
    const initialDeposit = document.getElementById("initialDeposit").value;

    if(firstName == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter firstName",
        })
        return;
    }

    if(lastName == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter lastName",
        })
        return;
    }
    if(email == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter email",
        })
        return;
    }

    if(mobile == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter mobile",
        })
        return;
    }

    if(nic == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter nic",
        })
        return;
    }

    if(initialDeposit == ""){
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Please enter Initial Deposit",
        })
        return;
    }

    const response = await fetch("http://localhost:8080/SmartBank/admin/user-register", {
        method: "POST",
        body: JSON.stringify({
            firstName: firstName,
            lastName: lastName,
            email: email,
            mobile: mobile,
            nic: nic,
            initialDeposit: initialDeposit,
        }),
        headers: {
            "Content-Type": "application/json",
        }
    });

    if(response.ok) {
        const json = await response.json();
        console.log(json);

        if(json.success) {
            Swal.fire({
                icon: "success",
                title: "Success",
                text: json.message,
            }).then((result) => {
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

});