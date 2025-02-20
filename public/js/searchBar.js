document.addEventListener('DOMContentLoaded', function () {
    console.log("searchBar.js loaded");
    const searchInput = document.getElementById('search-input');
    const categoryWrapper = document.getElementById('category-wrapper');
    const booksContainer = document.getElementById('books-container');
    const loadingDiv = document.getElementById('loading');
    const labelCategories = document.querySelectorAll('label[id^="label-category"]');
    const radioCategories = document.querySelectorAll('input[name="category"]');
    let isRequestInProgress = false;

    function updateLabelColors() {
        labelCategories.forEach(function (labelCategory) {
            const radioInput = document.getElementById(labelCategory.htmlFor);
            if (radioInput.checked) {
                labelCategory.classList.add('btn-primary-content');
                labelCategory.classList.remove('btn-primary');
            } else {
                labelCategory.classList.add('btn-primary');
                labelCategory.classList.remove('btn-primary-content');
            }
        });
    }

    // Uncheck all radio buttons on page load
    radioCategories.forEach(function (radioCategory) {
        radioCategory.checked = false;
    });

    async function fetchData(url) {
        if (isRequestInProgress) return;
        isRequestInProgress = true;
        loadingDiv.classList.remove('hidden');
        booksContainer.classList.add('hidden');

        try {
            const response = await fetch(url);
            const data = await response.json();
            if (booksContainer) {
                booksContainer.innerHTML = data.html;
            }
        } catch (error) {
            console.error('Error fetching data:', error);
        } finally {
            loadingDiv.classList.add('hidden');
            booksContainer.classList.remove('hidden');
            isRequestInProgress = false;
        }
    }

    labelCategories.forEach(function (labelCategory) {
        labelCategory.addEventListener('click', function (event) {
            const radioInput = document.getElementById(this.htmlFor);
            if (radioInput.checked) {
                event.preventDefault(); // Prevent the default behavior
                radioInput.checked = false;
                fetchData(`/search?q=`);
            } else {
                radioInput.checked = true;
                const categoryId = radioInput.value;
                fetchData(`/products/category/${categoryId}`);
            }
            updateLabelColors();
        });
    });

    // Initial call to set the correct styles
    updateLabelColors();

    if (searchInput) {
        searchInput.addEventListener('input', debounce(function () {
            const query = this.value.trim();
            categoryWrapper.style.display = query ? 'none' : 'block';
            fetchData(`/search?q=${encodeURIComponent(query)}`);
        }, 300));
    }
});

function debounce(func, delay) {
    let timeout;
    return function (...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(this, args), delay);
    };
}
