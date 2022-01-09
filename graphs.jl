# @file: graphs.jl
# @description: Calculate EDAP and produce the necessary graphs.

using DataFrames, CSV
using Plots

specbzip = DataFrame(CSV.File("data/specbzip_data.txt"));
spechmmer = DataFrame(CSV.File("data/spechmmer_data.txt"));
specsjeng = DataFrame(CSV.File("data/specsjeng_data.txt"));
speclibm = DataFrame(CSV.File("data/speclibm_data.txt"));
specmcf = DataFrame(CSV.File("data/specmcf_data.txt"));

benchmarks = [specbzip, spechmmer, specsjeng, speclibm, specmcf];
names = ["specbzip", "spechmmer", "specsjeng", "speclibm", "specmcf"];
rounds = [1, 3, 7, 10, 11];
n = length(rounds);

edap = DataFrame(
  specbzip = Vector{Float64}(undef, n),
  spechmmer = Vector{Float64}(undef, n),
  specsjeng = Vector{Float64}(undef, n),
  speclibm = Vector{Float64}(undef, n),
  specmcf = Vector{Float64}(undef, n),
);

for i = 1:5
  for j = 1:n
    edap[j, i] = benchmarks[i][j, 1] *
      (benchmarks[i][j, 3] + benchmarks[i][j, 4]) *
      benchmarks[i][j, 2];
  end
end

l = @layout [a{0.4h}; b c d];

for i = 1:5
  edap_p = plot(
    rounds, edap[!, 1], 
    linecolor = :orangered,
    markercolor = :orangered,
    marker = :circle,
    title = "EDAP",
    legend = false,
  );
  dynamic_p = plot(
    rounds, benchmarks[i][!, 3],
    linecolor = :red1,
    markercolor = :red1,
    marker = :circle,
    title = "Dynamic power",
    legend = false,
  );
  leakage_p = plot(
    rounds, benchmarks[i][!, 4],
    linecolor = :red2,
    markercolor = :red2,
    marker = :circle,
    title = "Leakage power",
    legend = false,
  );
  peak_p = plot(
    rounds, benchmarks[i][!, 5],
    linecolor = :red3,
    markercolor = :red3,
    marker = :circle,
    title = "Peak power",
    legend = false,  
  );

  p = plot(edap_p, dynamic_p, leakage_p, peak_p, layout = l);
  savefig(p, "output/info/" * names[i] * "_info.png");
end

