document.addEventListener('DOMContentLoaded', function () {
    console.log('order.js loaded');
    const mainCancelButtons = document.getElementById('main-cancel-btn');
    const confirmCancel = document.getElementById('confirmCancel');
    const cancelAlert = document.getElementById('cancelAlert');



    mainCancelButtons.addEventListener('click', function () {
        confirmCancel.classList.remove('hidden');
        mainCancelButtons.style.display = 'none';
    });

    cancelAlert.addEventListener('click', function () {
        console.log('clicked');
        confirmCancel.classList.add('hidden');
        mainCancelButtons.style.display = 'block';
    });

    confirmAlert.addEventListener('click', function () {
        console.log('clicked');
        confirmCancel.classList.add('hidden');
        mainCancelButtons.style.display = 'block';
    });

});