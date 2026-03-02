"use client"
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import React from 'react'

const SignIn = () => {
  const router = useRouter();
  const handleSignIn = async (e) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    
     try {
       const password = formData.get("password");
       const email = formData.get("email");

       const response = await fetch("http://localhost:5000/api/auth/login", {
         method: "POST",
         headers: {
           "Content-Type": "application/json",
         },
         body: JSON.stringify({ email, password }),
       });
       const data = await response.json();

       if(!response.ok){
         throw new Error(data.message); 
       }

       localStorage.setItem("token", data.token);
       localStorage.setItem("user", JSON.stringify(data.user));

       if (data.user.role === "admin") {
         router.push("/admin");
       } else {
        router.push("/students");
        }
       console.log(data);
     } catch (error) {
       console.log(error);
     }
   
  }
  return (
    <div className="flex min-h-screen items-center justify-center ">
      <Card className="">
        <CardHeader>
          <CardTitle>Sign in</CardTitle>
          <CardDescription>
            Sign in with your email and password
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form className="space-y-4" onSubmit={handleSignIn}>
            <Input type="email" name="email" placeholder="Email" required />
            <Input type="password" name="password" placeholder="Password" required/>
            {/* <Input type="password" placeholder="Confirm Password" required/> */}
            <Button type="submit">Sign In</Button>
          </form>
         <CardDescription className={`mt-4`}>Don't have an account? <Link className='text-blue-400' href="/sign-up">Sign Up</Link></CardDescription>
        </CardContent>
      </Card>
    </div>
  );
}

export default SignIn