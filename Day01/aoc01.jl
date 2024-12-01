# DAY 1
# Problem 1: What is the total distance between your lists?
using CSV
using DataFrames
# Read the input file
file = CSV.File(@__DIR__() * "/input01.csv") #, delim=';') 
df = DataFrame(file)
# Selecting appropriate columns
select!(df, Not([:2, :3]))
# Long Version
# sorted_columns = []
# for col in names(df)
#     sorted_col = sort(df[:, col])
#     push!(sorted_columns, sorted_col)
# end
# Short Version
sorted_columns = [sort(df[:, col]) for col in names(df)]
# Save the sorted columns in a CSV file
# sorted_df = DataFrame(sorted_columns, names(df))
# CSV.write(@__DIR__() * "/sorted_columns.csv", sorted_df)
# Find the difference between the two columns in sorted_columns and find the sum
result = sum(abs.(sorted_columns[1] .- sorted_columns[2]))
println("The total distance between my lists is: ", result)


# Problem 2: What is their similarity score?
#= Diagnostic =============================================================================
1. Check first if there is repeated elements in the first list
2. If not then add list 1 and list 2 together in one list then sorted it
3. Then check for repeated elements in the new list
4. Then similarity score = element * (count of the repeated elements - 1) 
==========================================================================================# 
using StatsBase
list1 = sorted_columns[1]
list2 = sorted_columns[2]
# Check for repeated numbers in list1 and list 2
repeated_elements_list1 = countmap(list1)
# println("Repeated elements in list1: ", filter(x -> x[2] > 1, repeated_elements_list1))
repeated_elements_list2 = countmap(list2)
# println("Repeated elements in list2: ", filter(x -> x[2] > 1, repeated_elements_list2))
# Combine list1 and list2 in one list and sort it
combined_list = vcat(list1, list2)
sorted_combined_list = sort(combined_list)
# Save the sorted_combined_list in a .txt file
# open(@__DIR__() * "/sorted_combined_list.txt", "w") do io
#     for element in sorted_combined_list
#         write(io, "$element\n")
#     end
# end
# Check for repeated numbers in the combined list
repeated_elements_combined_list = countmap(sorted_combined_list)
# println("Repeated elements in combined list: ", filter(x -> x[2] > 1, repeated_elements_combined_list))
repeated_elements_combined_list
# Convert dictionary of repeated elements into two column vectors
elements = collect(keys(repeated_elements_combined_list))
counts = collect(values(repeated_elements_combined_list))
# Similarity score calculation
similarity = zeros(length(elements))
for i in 1:length(elements)
    similarity[i] = elements[i] * (counts[i]-1)
end
total_similarity = Int(sum(similarity))
println("The similarity score is: ", total_similarity)