################################################################################
# ML > SL > Classification > Logistic Regression
################################################################################

using Plots
using CSV

gr(size = (600, 600))

# plot logistic (sigmoid) curve
logistic(x) = 1 / (1 + exp(-x))

# plot logistic function
p_logistic = plot(-6:0.1:6, logistic,
    xlabel = "Inputs (x)",
    ylabel = "Outputs (y)",
    title = "Logistic (Sigmoid) Curve",
    legend = false,
    color = :blue
)

# initialize parameters
global theta_0 = 0.0    # y-intercept
global theta_1 = 1.0    # slope

# hypothesis function
function z(x)
    global theta_0, theta_1
    theta_0 .+ theta_1 .* x
end

function h(x)
    global theta_0, theta_1
    1 ./ (1 .+ exp.(-z(x)))
end

# re-plot
plot!(h, color = :red, linestyle = :dash)

# load data
data = CSV.File("wolfspider.csv")

X = data.feature
Y_temp = data.class

Y = []
for i in 1:length(Y_temp)
    if Y_temp[i] == "present"
        y = 1.0
    else
        y = 0.0
    end
    push!(Y, y)
end

# plot data
p_data = scatter(X, Y,
    xlabel = "Size of Grains of Sand (mm)",
    ylabel = "Probability of Observation (Absent = 0 | Present = 1)",
    title = "Wolf Spider Presence Classifier",
    legend = false,
    color = :red,
    markersize = 5
)

################################################################################
# Logistic Regression Model
################################################################################

# initialize parameters again
global theta_0 = 0.0
global theta_1 = 1.0

# track parameter history
t0_history = []
t1_history = []

push!(t0_history, theta_0)
push!(t1_history, theta_1)

# hypothesis functions (reuse same definitions)

# plot initial hypothesis
plot!(0:0.1:1.2, h, color = :green)

# number of samples
m = length(X)

# initial prediction
y_hat = h(X)

# cost function
function cost()
    global y_hat, Y, m
    (-1 / m) * sum(
        Y .* log.(y_hat) +
        (1 .- Y) .* log.(1 .- y_hat)
    )
end

J = cost()

# track cost value history
J_history = []
push!(J_history, J)

# partial derivatives
function pd_theta_0()
    global y_hat, Y
    sum(y_hat - Y)
end

function pd_theta_1()
    global y_hat, Y, X
    sum((y_hat - Y) .* X)
end

# learning rate
alpha = 0.01

# initialize epochs
epochs = 0

################################################################################
# Gradient Descent Loop
################################################################################

for i in 1:1000
    global theta_0, theta_1, y_hat, J, epochs

    # calculate partial derivatives
    theta_0_temp = pd_theta_0()
    theta_1_temp = pd_theta_1()

    # update parameters
    theta_0 -= alpha * theta_0_temp
    theta_1 -= alpha * theta_1_temp

    push!(t0_history, theta_0)
    push!(t1_history, theta_1)

    # update predictions and cost
    y_hat = h(X)
    J = cost()
    push!(J_history, J)

    # replot prediction
    epochs += 1
    plot!(0:0.1:1.2, h, color = :blue, alpha = 0.025,
        title = "Wolf Spider Presence Classifier (epochs = $epochs)"
    )
end

p_data

################################################################################
# Post-training plots
################################################################################

# learning curve
p_l_curve = plot(0:epochs, J_history,
    xlabel = "Epochs",
    ylabel = "Cost",
    title = "Learning Curve",
    legend = false,
    color = :blue,
    linewidth = 2
)

# parameter path
p_params = scatter(t1_history, t0_history,
    xlabel = "theta_1",
    ylabel = "theta_0",
    title = "Gradient Descent Path",
    legend = false,
    color = :blue,
    alpha = 0.05
)

# make predictions
newX = [0.25, 0.5, 0.75, 1.0]
println("Predictions for newX: ", h(newX))

# # Mostrar o gráfico
# display(p_l_curve)
# # impede o script de fechar imediatamente
# readline()
