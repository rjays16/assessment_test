export function disableButton(selector, flag) {
    const buttons = document.querySelectorAll(selector);
    buttons.forEach(button => {
        button.disabled = flag;
    });
}
