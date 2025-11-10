# Regressão sem ML
using CSV, GLM, Plots, TypedTables

data = CSV.File("housingdata.csv")  # Abre o arquivo csv
X = data.size  # Primeira coluna do arquivo
Y = round.(Int, data.price / 1000)  # Segunda coluna do arquivo

t = Table(X = X, Y = Y) # Transforma o arquivo de entrada em uma tabela

# Plotar o arquivo
gr(size = (600, 600)) # Tamanho do gráfico

# Gráfico de dispersão = scatter plot
p_scatter = scatter(X, Y,
    xlims = (0, 5000),
    ylims = (0, 800),
    xlabel = "Size (sqft)",
    ylabel = "Price",
    title = "Housing Prices in Portland",
    legend = false,
    color = :red,
)

# # Mostrar o gráfico
# display(p_scatter)
# # impede o script de fechar imediatamente
# readline()

# # salvar
# save("grafico.png", p_scatter)

# Usar GLM para achar a curva de regressão
# GLM = Generalized Linear Models
ols = lm(@formula(Y ~ X), t)    # Gerar os coeficientes 
println(ols)

# Adcionar ao plot
plot!(X, predict(ols), color = :green, linewidth = 3)

# # Mostrar o gráfico
# display(p_scatter)
# # impede o script de fechar imediatamente
# readline()

# # salvar
# save("grafico.png", p_scatter)


# Agora prever um novo valor:
newX = Table(X = [1250])
println(predict(ols, newX))

# ------------------------------------------------------------------------------
# Regressão com ML
# ------------------------------------------------------------------------------

epochs = 0
# Gráfico de dispersão = scatter plot
p_scatter = scatter(X, Y,
    xlims = (0, 5000),
    ylims = (0, 800),
    xlabel = "Size (sqft)",
    ylabel = "Price",
    title = "Housing Prices in Portland (epochs = $epochs)",
    legend = false,
    color = :red,
)

# Inicializar parametros

# y = m*x + b, m = slope, b = y-intercept
θ_0 = 0 # b = y-intercept
θ_1 = 0 # m = slope

# definir modelo

h(x) = θ_0 .+ θ_1 * x

plot!(X, h(X), color = :blue, linewidth = 3)

# ------------------------------------------------------------------------------
# usar cost function do Andrew Ng
# ------------------------------------------------------------------------------

m = length(X)
ŷ = h(X)

function cost(X, Y)
    (1 / (2 * m)) * sum((ŷ - Y).^2)
end

J = cost(X, Y)

# push cost value into vector

J_history = []
push!(J_history, J)

# define batch gradient descent algorithm

# use partial derivative formula from Andrew Ng

function pd_theta_0(X, Y)
    (1 / m) * sum(ŷ - Y)
end

function pd_theta_1(X, Y)
    (1 / m) * sum((ŷ - Y) .* X)
end

# set learning rates (alpha)

alpha_0 = 0.09
alpha_1 = 0.00000008

################################################################################
# begin iterations (repeat until convergence)
################################################################################

# calculate partial derivatives

theta_0_temp = pd_theta_0(X, Y)

theta_1_temp = pd_theta_1(X, Y)

# adjust parameters by the learning rate

θ_0 -= alpha_0 * theta_0_temp

θ_1 -= alpha_1 * theta_1_temp

# recalculate cost

ŷ = h(X)

J = cost(X, Y)

push!(J_history, J)
println(θ_1)

# replot prediction

epochs += 1

plot!(X, ŷ, color = :blue, alpha = 0.5,
    title = "Housing Prices in Portland (epochs = $epochs)"
)
display(p_scatter)
readline()

################################################################################
# end iterations
################################################################################