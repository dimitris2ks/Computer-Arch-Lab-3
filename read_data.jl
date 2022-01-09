# @file: read_data.jl
# @description: Read data -in quite a lazy way- from the McPAT
# and GEM5 output files.

using DataFrames, CSV

rounds = [1 3 7 10 11];
benchmarks = ["specbzip" "spechmmer" "speclibm" "specmcf" "specsjeng"];

leakage_power = Vector{Float64}(undef, 5);
dynamic_power = Vector{Float64}(undef, 5);
peak_dynamic = Vector{Float64}(undef, 5);
area = Vector{Float64}(undef, 5);
runtime = Vector{Float64}(undef, 5);

for benchmark in benchmarks
  for round in 1:length(rounds)
    stats_filename = benchmark * "/round" * string(rounds[round]) * "/stats.txt"
    results_filename = benchmark * "/round" * string(rounds[round]) * "/results_" * string(rounds[round]) * ".txt"

    stats = readlines(stats_filename);
    runtime[round] = parse(Float64, stats[12][46:54]);

    # Rounds 1 and 11 show one less warning. So we add one line to the rest of the rounds.
    extra_line = (round == 1 || round == 5) ? 0 : 1;
    results = readlines(results_filename);

    area[round] = parse(Float64, results[61 + extra_line][14:end-5]) +
      parse(Float64, results[277 + extra_line][14:end-5]);
    peak_dynamic[round] = parse(Float64, results[62 + extra_line][22:end-2]) +
      parse(Float64, results[278 + extra_line][22:end-2]);
    dynamic_power[round] = parse(Float64, results[66 + extra_line][25:end-2]) +
      parse(Float64, results[282 + extra_line][25:end-2]);
    leakage_power[round] = parse(Float64, results[63 + extra_line][30:end-2]) +
      parse(Float64, results[279 + extra_line][30:end-2]);

    data = DataFrame(
      runtime = runtime,
      area = area,
      dynamic = dynamic_power,
      leakage = leakage_power,
      peak = peak_dynamic
    )

    CSV.write("data/" * benchmark * "_data.txt", data);    
  end
end


