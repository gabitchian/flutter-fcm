importScripts(
  'https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js',
);
importScripts(
  'https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js',
);

firebase.initializeApp({
  apiKey: '',
  authDomain: '',
  projectId: '',
  storageBucket: '',
  messagingSenderId: '',
  appId: '',
  measurementId: '',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();
