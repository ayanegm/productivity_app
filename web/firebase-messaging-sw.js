importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

// استبدلي هذه البيانات ببيانات مشروعك من ملف firebase_options.dart
firebase.initializeApp({
    apiKey: 'AIzaSyBPZDJs-q9dUyLlZCM3IbyFbaw8TJezX0M',
    authDomain: 'productivity-app-2bf41.firebaseapp.com',
    projectId: 'productivity-app-2bf41',
    storageBucket: 'productivity-app-2bf41.firebasestorage.app',
    messagingSenderId: '80375516886',
    appId: '1:80375516886:web:e132cd5f0d54356c158377',
});

const messaging = firebase.messaging();