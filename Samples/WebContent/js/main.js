const input = document.querySelectorAll(".js-input"),
    label = document.querySelectorAll(".js-label"),
    nextSubmitBtn = document.querySelectorAll(".js-nextBtn"),
    inner_wrapper_A = document.querySelector(".js-email"),
    inner_wrapper_B = document.querySelector(".js-pw");


const a = document.querySelectorAll("a");
let index = -1;

function inputRemoveEvent(ev) {
    let deleteindex = index;
    console.log("delete index : " + deleteindex);
    setTimeout(() => {
        input[deleteindex].placeholder = label[deleteindex].innerText;
        label[deleteindex].classList.remove("show");
    }, 300);
    TweenMax.to(label[deleteindex], 0.3, {
        top: "42px",
        left: "16px",
        fontSize: "16px",
        fontWeight: "400"
    });

}

function inputClickEvent(ev) {
    index = Array.from(input).indexOf(ev.target);
    let target = ev.currentTarget;

    target.placeholder = "";
    label[index].className = "show";
    TweenMax.to(label[index], 0.2, {
        top: 2,
        left: 0,
        fontSize: "14px",
    });
    console.log("Active index : " + index);
}

// function nextBtnEvent(e) {
//     e.preventDefault();

//     TweenMax.to(inner_wrapper_A, 0.2, {
//         left: "-100%",
//     });
//     setTimeout(() => {
//         location.href = "password.html";
//     }, 200);
// }

function init() {
    for (let i = 0; i < input.length; i++) {
        input[i].addEventListener("focus", inputClickEvent);
    }

    for (let i = 0; i < input.length; i++) {
        input[i].addEventListener("blur", () => {
            if (input[i].value == "") {
                inputRemoveEvent();
            }
        });
    }

    window.addEventListener("load", () => {
        input[0].focus();
    });

    // nextSubmitBtn.forEach(el => {
    //     el.addEventListener("click", nextBtnEvent);
    // });
}

init();