<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ProductController;
use App\Http\Controllers\ShoppingCartController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\WishlistController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\StaticPageController;
use App\Http\Controllers\ReviewProductController;
use App\Http\Controllers\PasswordResetController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\DeleteAccountController;




/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/


//mainpage
Route::controller(ProductController::class)->group(function () {
    Route::get('/mainpage', 'index')->name('mainpage.index');
    Route::get('/product/{id}', 'show')->name('product.show');
});

// Home
Route::redirect('/', '/login');

// Authentication
Route::controller(LoginController::class)->group(function () {
    Route::get('/login', 'showLoginForm')->name('login');
    Route::post('/login', 'authenticate');
    Route::get('/logout', 'logout')->name('logout');
});

Route::controller(RegisterController::class)->group(function () {
    Route::get('/register', 'showRegistrationForm')->name('register');
    Route::post('/register', 'register');
});

// Checkout
Route::get('/checkout', [CheckoutController::class, 'index'])->name('checkout');
//Route::post('/checkout', [CheckoutController::class, 'process'])->name('checkout.process');
Route::post('/checkout/{shoppingCartId}/process', [CheckoutController::class, 'processOrder'])->name('checkout.process');



// Profile
Route::middleware(['auth'])->group(function () {
    Route::get('/profile', [ProfileController::class, 'show'])->name('profile.show');
    Route::post('/profile/{id}/update', [ProfileController::class, 'update'])->name('profile.update');
    Route::post('/profile/{id}/update-avatar', [ProfileController::class, 'updateAvatar'])->name('profile.updateAvatar');


    // Wishlist
    Route::post('/wishlist/add-product', [WishlistController::class, 'addProduct'])->name('wishlist.addProduct');
    Route::delete('/wishlist/remove-product', [WishlistController::class, 'removeProduct'])->name('wishlist.removeProduct');

    // Orders
    Route::get('/order/{id}', [OrderController::class, 'index'])->name('order.show');
    Route::delete('/order/{id}', [OrderController::class, 'deleteOrder'])->name('order.delete');
    Route::get('/allOrders', [OrderController::class, 'allOrders'])->name('order.all');
});



// Shopping Cart
Route::middleware(['restrictAdminAccess'])->group(function () {
    Route::get('/shoppingCart', [ShoppingCartController::class, 'index'])->name('shoppingCart');
    Route::delete('/shoppingCart/remove-product', [ShoppingCartController::class, 'removeProduct'])->name('shoppingCart.removeProduct');
    Route::post('/shoppingCart/add-product', [ShoppingCartController::class, 'addProduct'])->name('shoppingCart.addProduct');
    Route::get('/api/cart/item-count', [ShoppingCartController::class, 'getItemCount'])->name('shoppingCart.itemCount');
    Route::get('/api/cart/subtotal', [ShoppingCartController::class, 'getSubtotal'])->name('shoppingCart.subtotal');
});

// Search 
Route::controller(ProductController::class)->group(function () {
    Route::get('/search', 'search')->name('search');
    Route::get('/products/category/{id_category}', 'searchCategory')->name('search.category');
});


Route::post('/review-product', [ReviewProductController::class, 'createReviewProduct'])->name('ReviewProduct.create');

Route::middleware(['auth'])->group(function () {

    Route::post('/reviews/update/{id}', [ReviewProductController::class, 'ajaxUpdate'])->name('reviews.ajaxUpdate');

    Route::delete('/reviews/destroy/{id}', [ReviewProductController::class, 'ajaxDestroy'])->name('reviews.ajaxDestroy');
});



// Admin routes
Route::prefix('admin')->middleware(['auth', 'isAdmin'])->group(function () {
    // Dashboard
    Route::get('/dashboard', [AdminController::class, 'showDashboard'])->name('admin.dashboard');


    // Product management
    Route::get('/mainpage', [ProductController::class, 'index'])->name('adminmainpage.index');
    Route::get('/add-product', [ProductController::class, 'showAddProductForm'])->name('admin.addProduct');
    Route::post('/add-product', [ProductController::class, 'addProduct'])->name('admin.addProduct.submit');
    Route::get('/manage-products', [ProductController::class, 'manageProducts'])->name('admin.manageProducts');
    Route::get('/products/{id}/edit', [ProductController::class, 'edit'])->name('products.edit');
    Route::put('/products/{id}', [ProductController::class, 'update'])->name('products.update');
    Route::delete('/products/{id}', [ProductController::class, 'destroy'])->name('products.destroy');

    // Order management
    Route::get('/manage-orders', [AdminController::class, 'showManageOrders'])->name('admin.manageOrders');
    Route::post('/update-order-status', [AdminController::class, 'updateOrderStatus'])->name('admin.updateOrderStatus');

    // Author management
    Route::post('/authors', [AdminController::class, 'store'])->name('admin.authors.add');
    Route::delete('/authors/{id}', [AdminController::class, 'destroy'])->name('admin.authors.delete');

    // Ban Users
    Route::get('/manage-users', [AdminController::class, 'showManageUsers'])->name('admin.manageUsers');
    Route::post('/ban-user', [AdminController::class, 'banUser'])->name('admin.banUser');

    //Manage Categories
    Route::get('/categories', [ProductController::class, 'indexCategories'])->name('categories.index');
    Route::delete('/categories/{id}', [ProductController::class, 'deleteCategory'])->name('categories.delete');
    Route::post('/categories/add', [ProductController::class, 'addCategory'])->name('categories.add');
});

// Static pages route
Route::get('/about', [StaticPageController::class, 'about'])->name('about');
Route::get('/contact', [StaticPageController::class, 'contact'])->name('contact');
Route::get('/faq', [StaticPageController::class, 'faq'])->name('faq');

// Password recovery via email routes

// Para exibir o formulário de solicitação de redefinição de senha
Route::get('/password/request', function () {
    return view('emails.request-password');
})->name('password.request');
// Para processar a solicitação de envio de token (mantém o método POST)
Route::post('/password/request', [PasswordResetController::class, 'sendResetToken'])->name('password.request.post');

// Página para verificar o token
Route::get('/password/verify-token', function () {
    return view('emails.verify-token', ['email' => session('email')]);
})->name('password.verifyToken');

// Processa a verificação do token
Route::post('/password/verify-token', [PasswordResetController::class, 'verifyToken'])->name('password.verifyToken.post');

// Página para redefinir a senha
Route::get('/password/reset', function () {
    return view('emails.reset-password', [
        'email' => session('email'),
        'token' => session('token'),
    ]);
})->name('password.reset')->middleware('ensure.valid.password.reset');

// Processa a redefinição da senha
Route::post('/password/reset', [PasswordResetController::class, 'resetPassword'])->name('password.reset.post');

// Notifications
Route::middleware(['auth'])->group(function () {
    Route::get('/notification', [NotificationController::class, 'getNotification'])->name('notification.get');
    Route::post('/notification/{id}/read', [NotificationController::class, 'markAsRead'])->name('notification.read');
});
Broadcast::routes(['middleware' => ['auth']]);  
/*
//Wishlist
Route::middleware(['auth'])->group(function () {
    Route::post('/wishlist/add-product', [WishlistController::class, 'addProduct'])->name('wishlist.addProduct');
    //Route::post('/wishlist/remove-product', [WishlistController::class, 'removeProduct'])->name('wishlist.removeProduct');
});*/

Route::post('/account/anonymize', [DeleteAccountController::class, 'anonymize'])->name('account.anonymize');
