println("hello world")
# https://juliabyexample.helpmanual.io/
a = 1 + 17
println(a)
println("hello world")

# =========== DICTONARIES ===========
d1 = Dict("A" => 1, "B" => 2)
println(d1)
println(d1["A"])

d2 = Dict("C" => 3, "D" => 4)
println(d2)
println(d2["C"])

d3 = merge(d1, d2)
push!(d3, "G" => 350)
println(d3)

pop!(d3, "G")
println(d3)

# =========== TUPLE ===========
tp1 = (1,)
tp2 = (1, 3.14, "tuple",)
println(tp2[2])

# =========== ARRAYS ===========
vetor = [1, 2, 3, 4]
println(vetor)
matriz = [1 2 3 4; 
          1 2 3 4]
println(matriz)


println(vetor[1])
println(matriz[1,2])

m2 = fill(2.0, 5, 5)
println(m2)

m3 = zeros(5, 5)
println(π)


println(1 ∈ vetor) #\in TAB ou \notin


# =========== CONDITIONS ===========
if π > 2
    println("é")
else
    println("nao é")
end

x = 1
y = 2

x > y ? println("x ´maior") : println("y ´maior")

# =========== LOOPS ===========
vetor = [12, 22, 32, 42]
for item in vetor
    println(item)
end

matriz = [21 22 23 24; 
          31 32 33 34]

println(size(matriz))
linhas, colunas = size(matriz)

for i in 1:linhas
    for j in 1:colunas
        println("Linha: ", i, " Coluna: ", j)
    end
end

# =========== FUNCTIONS ===========
function somar(x, y)
    return x + y
end

println(somar(π, 5))


function lista(x...)
    println("Numero de itens a comprar: ", length(x))
    println("Numero de itens a comprar: $(length(x))")
end

println(somar(π, 5))
lista("water", "agua")