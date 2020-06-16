using LinearAlgebra
using Plots
x = [ [1, 2.5, 8] , [1 5.5 9]' , [1 7.7 20]', [1 9 12]', [1  2 25]', [1 4 30]', [1  5.1 24]', [1 6.6 37]']
y = [ 1,1,1,1,-1,-1,-1,-1]
w= ones(3)
x1=[];
x2=[];

for i=1:8
    insert!(x1,length(x1)+1,x[i][2])
    insert!(x2,length(x2)+1,x[i][3])
end

#plt=plot(x1,x2,seriestype=:scatter,show=true)
plt=plot(x1[1:4],x2[1:4],seriestype=:scatter)
plot!(x1[5:8],x2[5:8],seriestype=:scatter)
gui(plt)

function IndexOfWrongPrediction(w,x,y)
    for i=1:length(x)
        v = w'*x[i]
        if (v[1]/abs(v[1])) != y[i]
            return i
        end
    end
    return -1
end

i=IndexOfWrongPrediction(w,x,y)
while i>0
    global w,y,x,i 
    w =  w + y[i]*x[i]
    i=IndexOfWrongPrediction(w,x,y)
end

alpha = -w[2]/w[3]
beta = -w[1]/w[3]
t=0:1:10
plot!(t,t->alpha*t+beta)
#plt!(t,t->alpha*t+beta)

wait_for_key(prompt) = (print(stdout, prompt); read(stdin, 1); nothing)
wait_for_key("press any key to continue")
