"use client"
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import React from 'react'

const SignUp = () => {
  const router = useRouter();
  const handleSignIn = async (formData) => {
    
     try {
       const password = formData.get("password");
       const email = formData.get("email");
       const name = formData.get("name");

       const response = await fetch("http://localhost:5000/api/auth/register", {
         method: "POST",
         headers: {
           "Content-Type": "application/json",
         },
         body: JSON.stringify({ name,email, password }),
       });
       const data = await response.json();
       console.log(data);

       if(!response.ok){
         throw new Error(data.message); 
       }

       localStorage.setItem("token", data.token);
       localStorage.setItem("user", JSON.stringify(data.user));

       router.push("/sign-in");
 
     } catch (error) {
       console.log(error);
     }
   
  }
  return (
    <div className="flex min-h-screen items-center justify-center ">
      <Card className="">
        <CardHeader>
          <CardTitle>Sign Up</CardTitle>
          <CardDescription>
            Sign up with your email and password
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form className="space-y-4" action={handleSignIn}>
            <Input type="text" name="name" placeholder="Name" required/>
            
            <Input type="email" name="email" placeholder="Email" required />
            <Input type="password" name="password" placeholder="Password" required/>
            {/* <Input type="password" placeholder="Confirm Password" required/> */}
            <Button type="submit">Sign In</Button>
          </form>
         <CardDescription className={`mt-4`}>Already have an account? <Link className='text-blue-400' href="/sign-in">Sign in</Link></CardDescription>
        </CardContent>
      </Card>
    </div>
  );
}

export default SignUp