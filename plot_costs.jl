# @file: plot_costs.jl
# @description: Plot the cost function for the selected rounds: 1, 3, 7, 10, 11.

using DataFrames, CSV
using PlotlyJS

cost_function = DataFrame(CSV.File("data/cost_function.txt"))
rounds = [1, 3, 7, 10, 11];
names = ["specbzip", "spechmmer", "specsjeng", "speclibm", "specmcf"];
plots = Vector{GenericTrace}(undef, 5); # one plot for each benchmark.

# Scatter plot for each benchmark.
for i = 1:5
  plots[i] = scatter(
    x = rounds,
    y = cost_function[rounds, i+1],
    name = names[i],
  );
end

# Put them all in a plot.
cost_plot = plot(plots);
cost_plot.plot.layout["title"] = "Cost function for selected rounds"
savefig(cost_plot, "output/cost_function/cost_function.jpeg", width = 872, height = 654);
