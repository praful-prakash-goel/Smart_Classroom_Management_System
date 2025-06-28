#include<stdio.h>
//int main(){
//     int n , i ,j;
//     printf("Enter the size of array:");
//     scanf("%d",&n) ;
//     int arr[n] ;
//     printf("Enter the elements of array ");
//     for(int i=0;i<n;i++){
//     scanf("%d",&arr[i]);
//     }

//     printf("All the unique elements are:");
//     for( i=0 ; i<n ; i++){
//         for( j=1 ; j<n ; j++){
//             if(arr[i] != arr[j])
//             printf("%d",arr[j]) ;
//         }
//         break ;
//     }


//     for(i=0 ; i<n ; i++){
//        int count = 0 ;
//           for( j=i+1; j<n ; j++){
//                if(arr[i]!=arr[j]){
//               printf("The frequency of %d is %d \n",arr[i],1) ;
//             }
//             else if(arr[i]==arr[j]){
//                 count++ ;
//              printf("The frequency of %d is %d \n",arr[i],1) ;
//              }
             

//           }
//     }

// return 0;
     
// }
int main(){
int n,i , j ;
printf("Enter the size of array :") ;
scanf("%d \n",&n);
int arr[n];
printf("Enter the elements of array: \n");
for(i=0 ;i<n;i++){
    scanf("%d",&arr[i]);
}

printf("\n");

int brr[n];
printf("Enter the elements of array:\n");
for(i=0 ;i<n;i++){
    scanf("%d",&brr[i]);
}
//elements are given to a new array 
int crr[2*n];
for(i=0 ; i<2*n;i++ ){
    if(i<n)
    crr[i]=arr[i] ;

     else if(i==n)
        crr[i] = brr[0] ;
    
    else  if( i>n)
        crr[i] = brr[2*n-i] ;
    
}
//now sorting 
for(i=0 ; i<2*n; i++){
    for(j=i+1; j<2 * n; j++){
        if(crr[i] < crr[j]){
            int temp = crr[i] ;
            crr[i] = crr[j] ;
            crr[j] = temp ;
        }

    }
}
printf("numbers in descending order are :") ;
printf("\n") ;
for(i=0 ;i<2*n ;i++){
printf("%d",crr[i]) ;
}

return 0 ;
}