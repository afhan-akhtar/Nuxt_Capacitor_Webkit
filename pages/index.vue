<template>
    <div>
      <h1 style="margin-top: 100px;">Send HTML Content to Swift using WebKit</h1>
      <button @click="sendHtmlContent">Send HTML Content</button>
    </div>
  </template>
  
  <script setup>
  import { Capacitor } from '@capacitor/core';
  
  const sendHtmlContent = () => {
    const htmlContent = '<h2>Hello from Nuxt 3!</h2>';
  
    // Log the platform to see if we're on iOS, Android, or Web
    const platform = Capacitor.getPlatform();
    console.debug("Running on platform:", platform);
  
    // Check if it's running on iOS, then send HTML content via WebKit if available
    if (platform === 'ios') {
      console.log("Running on iOS platform.");
  
      // Using WebKit message handlers to send content to Swift
      if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.sendHtmlContent) {
        console.log("WebKit message handler found, sending content...");
        window.webkit.messageHandlers.sendHtmlContent.postMessage(htmlContent);
        console.log("HTML content sent to Swift successfully.");
      } else {
        console.error("WebKit message handler is not available.");
      }
    } else if (platform === 'android') {
      console.log("Running on Android platform.");
      // Handle sending to Android or other specific logic for Android here
      // You can integrate Android-specific Capacitor plugins or message handlers if needed
    } else {
      console.log("Running in a web environment.");
      // Logic for web platform (for testing purposes in a browser)
      console.log("This will only work on iOS or Android in a native environment.");
    }
  }
  </script>
  