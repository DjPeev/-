import sys 
def can_transport(capacity, N,K, weights ):
    used=[False]*N
    transported=0

    for i in range(K):
        current_cap=capacity
        for i in range(N):
            if not used[i] and weights[i] <= current_cap:
                used[i]=True
                current_cap-=weights[i]
                transported +=1
                if transported == N:
                    return True
    return transported==N

def main():
    try:
        line1=input().split()
        if not line1:
            return
        N,K= int(line1[0]), int(line1[1])
        line2=input().split()
        weights=[int(x) for x in line2]
    except(EOFError,IndexError):
       return 
    
    weights.sort(reverse=True)

    low=weights[0]
    high=sum(weights)
    ans=high

    while low <= high:
        mid=(low+high)//2
        if can_transport(mid,N,K,weights):
            ans=mid
            high=mid+1
        else:
            low=mid+1
    print(ans)

if __name__=="__main__":
    main()