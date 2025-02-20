document.addEventListener('DOMContentLoaded', function () {
    console.log('Document is fully loaded and parsed');

    const loadingSpinner = document.getElementById('loading-categories');
    const categoryList = document.getElementById('category-list');
    const addCategoryButton = document.getElementById('add-category-button');
    const newCategoryNameInput = document.getElementById('new-category-name');

    async function fetchWithLoading(url, options = {}) {
        setLoading(true);
        try {
            const response = await fetch(url, options);
            return await response.json();
        } catch (error) {
            console.error('Error fetching data:', error);
            throw error;
        } finally {
            setLoading(false);
        }
    }

    function setLoading(isLoading) {
        loadingSpinner.style.display = isLoading ? 'block' : 'none';
        categoryList.style.display = isLoading ? 'none' : 'block';
        addCategoryButton.disabled = isLoading;
        newCategoryNameInput.disabled = isLoading;
    }

    async function fetchCategories() {
        try {
            const categories = await fetchWithLoading('/admin/categories');
            renderCategories(categories.html);
        } catch (error) {
            console.error('Error fetching categories:', error);
        }
    }

    function renderCategories(html) {
        categoryList.innerHTML = html;
        addDeleteEventListeners();
    }

    function addDeleteEventListeners() {
        const deleteButtons = document.querySelectorAll('.delete-category-button');
        deleteButtons.forEach(button => {
            button.addEventListener('click', handleDeleteButtonClick);
        });
    }

    async function handleDeleteButtonClick(event) {
        event.preventDefault();
        const categoryId = this.getAttribute('data-category-id');
        console.log(`Delete button clicked for category ID: ${categoryId}`);
        await deleteCategory(categoryId);
    }

    async function deleteCategory(categoryId) {
        try {
            const result = await fetchWithLoading(`/admin/categories/${categoryId}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                }
            });
            if (result.success) {
                fetchCategories();
            } else {
                alert(result.error);
            }
        } catch (error) {
            console.error('Error deleting category:', error);
        }
    }

    async function addCategory(categoryName) {
        try {
            const result = await fetchWithLoading('/admin/categories/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                },
                body: JSON.stringify({ categoryname: categoryName })
            });
            if (result.success) {
                console.log('Category added successfully');
                fetchCategories();
                newCategoryNameInput.value = ''; // Clear the input field
            } else {
                alert(result.error);
            }
        } catch (error) {
            console.error('Error adding category:', error);
        }
    }

    addCategoryButton.addEventListener('click', function () {
        const categoryName = newCategoryNameInput.value.trim();
        if (categoryName) {
            addCategory(categoryName);
        } else {
            alert('Please enter a category name.');
        }
    });

    fetchCategories();
});

