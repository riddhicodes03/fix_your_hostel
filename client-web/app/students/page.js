"use client"
import { useRouter } from 'next/navigation';
import React, { useEffect } from 'react'

const StudentsPage = () => {
  const router = useRouter();

  useEffect(() => {
   const token = localStorage.getItem("token");

   if(!token){
    router.push("/sign-in");
   }

   if(token){
      const payload = JSON.parse(atob(token.split(".")[1]));
      if(payload.role !== "hosteller"){
       router.push("/sign-in");
      }
   }
  
  },[])
  
  return (
    <div>StudentsPage</div>
  )
}

export default StudentsPage