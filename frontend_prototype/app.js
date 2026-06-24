// Simple Vanilla JS for Single Page Application navigation

function login() {
    const btn = document.querySelector('#login-form .btn-primary');
    btn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Authenticating...';
    
    // Simulate network request delay for "wow" factor
    setTimeout(() => {
        document.getElementById('login-page').classList.remove('active');
        document.getElementById('login-page').classList.add('hidden');
        
        const appWrapper = document.getElementById('app-wrapper');
        appWrapper.classList.remove('hidden');
        
        // Slight delay to allow display:flex to apply before animating opacity
        setTimeout(() => {
            appWrapper.style.animation = 'fadeIn 0.5s ease-out forwards';
        }, 50);
    }, 800);
}

function logout() {
    document.getElementById('app-wrapper').classList.add('hidden');
    document.getElementById('app-wrapper').style.animation = '';
    
    const loginPage = document.getElementById('login-page');
    loginPage.classList.remove('hidden');
    loginPage.classList.add('active');
    
    const btn = document.querySelector('#login-form .btn-primary');
    btn.innerHTML = 'Access System <i class="fa-solid fa-arrow-right"></i>';
}

function navigate(viewId, navElement) {
    // Hide all views
    const views = document.querySelectorAll('.view');
    views.forEach(view => {
        view.classList.remove('active');
        view.classList.add('hidden');
    });

    // Show target view
    const targetView = document.getElementById(viewId);
    if(targetView) {
        targetView.classList.remove('hidden');
        targetView.classList.add('active');
    }

    // Update Sidebar active state
    if(navElement) {
        const navLinks = document.querySelectorAll('.nav-links li');
        navLinks.forEach(link => link.classList.remove('active'));
        navElement.classList.add('active');
    }

    // Update Page Title dynamically
    const pageTitle = document.getElementById('page-title');
    pageTitle.innerText = viewId.charAt(0).toUpperCase() + viewId.slice(1);
    if(viewId === 'batches') pageTitle.innerText = 'Inventory Batches';
}
