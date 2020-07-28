const btn = document.querySelectorAll('a');

btn.forEach(el => {
    el.style.overflow = 'hidden';
    el.addEventListener('click', function(e) {
        let x = e.offsetX;
        let y = e.offsetY;

        let ripples = document.getElementsByClassName('ripple');

        if (ripples.length < 10) { // this restricts the user from creating lots of ripples
            var ripple = document.createElement('span');
            ripple.classList.add('ripple');
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            if (this.getAttribute("class") == "btn primary") {
                ripple.style.backgroundColor = "background-color: rgba(0, 0, 0, 1);"
                ripple.style.filter = "brightness(0.1)";
            }
            this.appendChild(ripple);

            setTimeout(function() {
                ripple.remove();
            }, 1000);
        }
    });
})