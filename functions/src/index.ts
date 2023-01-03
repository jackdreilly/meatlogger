import * as functions from "firebase-functions";
import admin from "firebase-admin";
import {FieldValue} from "firebase-admin/firestore";

admin.initializeApp();

export const recomputeLiftRankings = functions.firestore.document(
    "users/{user_id}/logs/{log_id}",
).onCreate(
    (s) => admin.firestore().collection("lifts").doc(
        s.data().lift).update({"count": FieldValue.increment(1)}));
