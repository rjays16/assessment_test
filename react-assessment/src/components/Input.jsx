import React, {useContext, useState} from "react";
import Attach from "../img/attachment.png"
import Img from "../img/add_photo.png";
import {AuthContext} from "../context/AuthContext";
import {ChatContext} from "../context/ChatContext";
import { v4 as uuid } from "uuid";
import { getDownloadURL, uploadBytesResumable, ref} from "firebase/storage";
import {doc, arrayUnion, Timestamp, updateDoc, serverTimestamp} from "firebase/firestore";
import { db, storage} from "../firebase";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Picker from 'emoji-picker-react';

const Input = () => {
    const [text, setText] = useState("");
    const [img, setImg] = useState(null);

    const { currentUser } = useContext(AuthContext);
    const { data } = useContext(ChatContext);

    const [showPicker, setShowPicker] = useState(false);

    const onEmojiClick = async (event, emojiObject) => {
        setText(prevInput => prevInput + emojiObject.emoji);
        setShowPicker(false);
    }

    const handleSend =  async () => {
        if (img) {
                toast(currentUser.displayName + " Send a message with image")
            const storageRef = ref(storage, uuid());
            const uploadTask = uploadBytesResumable(storageRef, img);

            uploadTask.on(
                (error) => {
                },
                () => {
                    getDownloadURL(uploadTask.snapshot.ref).then(async (downloadURL) => {
                        await updateDoc(doc(db, "chats", data.chatId), {
                            messages: arrayUnion({
                                id: uuid(),
                                text,
                                senderId: currentUser.uid,
                                date: Timestamp.now(),
                                img: downloadURL
                            }),
                        });
                    });
                });
        } else {
            toast(currentUser.displayName + " Send a message")
            await updateDoc(doc(db, "chats", data.chatId), {
                messages: arrayUnion({
                    id: uuid(),
                    text,
                    senderId: currentUser.uid,
                    date: Timestamp.now(),
                }),
            });
        }
        
        await updateDoc(doc(db,"userChats", currentUser.uid), {
            [data.chatId + ".lastMessage"]: {
                text,
            },
            [data.chatId + ".date"]: serverTimestamp(),
        });
        await updateDoc(doc(db,"userChats", data.user.uid), {
            [data.chatId + ".lastMessage"]: {
                text,
            },
            [data.chatId + ".date"]: serverTimestamp(),
        })

        setText("");
        setImg(null);
    };
    return(
        <div className="input">
            <input type="text" placeholder="Type something..." value={text} onChange={e=>setText(e.target.value)}/>
            <div className="send">
                <img
                    className="emoji-icon"
                    src="https://icons.getbootstrap.com/assets/icons/emoji-smile.svg"
                    onClick={() => setShowPicker(val => !val)} />
                {showPicker &&
                <Picker
                    pickerStyle={{ width: '100%' }}
                    onEmojiClick={(emojiObject)=> setText((prevInput)=> prevInput + emojiObject.emoji)} />}
                <input type="file" style={{display:"none"}} id="file" onChange={e=>setImg(e.target.files[0])}/>
                <label htmlFor="file">
                    <img src={Img} alt=""/>
                </label>
                <button onClick={handleSend}>Send</button>
            </div>
            <ToastContainer />
        </div>
    )
}

export default Input