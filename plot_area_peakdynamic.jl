# @file plot_area_peakdynamic.jl
# @description: Plot the relation between area and peak dynamic power per benchmark.

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

l = @layout [a; b];

for i = 1:5
  area_p = plot(
    rounds, benchmarks[i][!, 2], 
    linecolor = :orangered,
    markercolor = :orangered,
    marker = :circle,
    title = "Area",
    legend = false,
  );
  peak_p = plot(
    rounds, benchmarks[i][!, 5],
    linecolor = :red3,
    markercolor = :red3,
    marker = :circle,
    title = "Peak dynamic",
    legend = false,
  );

  p = plot(area_p, peak_p, layout = l);
  savefig(p, "output/area-peak_dynamic/" * names[i] * "_area_to_peak.png");
end

