/* eslint-disable object-curly-spacing */
/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

initializeApp();

const db = getFirestore();

export const onChatCreated = onDocumentCreated(
  "chats/{chatId}",
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const chat = snap.data();
    const chatId = event.params.chatId;

    console.log("chat", chat);
    console.log("chatId", chatId);

    const notification = {
      type: "test type",
      createdAt: Date.now(),
      updatedAt: Date.now(),
    };

    await db.collection("notifications").add(notification);
  }
);

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
