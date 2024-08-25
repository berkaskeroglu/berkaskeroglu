using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Microsoft.Data.SqlClient;
using System.IO;

namespace SoccerStatsCreater
{
	class Program
	{
		static void Main(string[] args)
		{
			string filePath = @"*****\matches.txt"; // File's location
			string connectionString = @"****"; // MSSQL connection string

			Console.WriteLine("Add operation:1, Statistics:2");
			var choice = Console.ReadLine();
			int choiceInt = int.Parse(choice);

			if (choiceInt == 1)
			{
				string text = File.ReadAllText(filePath);

				text = Regex.Replace(text, @"(?i)(stats|\bMS\b|\d+:\d+)", "", RegexOptions.Multiline);

				string pattern = @"(?<team1>[^0-9\(\)]+?)\s*(?<homeFinal>\d+)-(?<awayFinal>\d+)\s*(?<team2>[^0-9\(\)]+?)\s*\((?<homeFirst>\d+)-(?<awayFirst>\d+)\)";
				Regex regex = new Regex(pattern);

				var matches = regex.Matches(text);

				using (SqlConnection connection = new SqlConnection(connectionString))
				{
					connection.Open();

					foreach (Match match in matches)
					{
						var homeTeam = match.Groups["team1"].Value.Trim();
						var awayTeam = match.Groups["team2"].Value.Trim();
						var homeFinal = int.Parse(match.Groups["homeFinal"].Value);
						var awayFinal = int.Parse(match.Groups["awayFinal"].Value);
						var homeFirst = int.Parse(match.Groups["homeFirst"].Value);
						var awayFirst = int.Parse(match.Groups["awayFirst"].Value);

						Console.WriteLine($"Home Team: {homeTeam}");
						Console.WriteLine($"Away Team: {awayTeam}");
						Console.WriteLine($"Home Final: {homeFinal}");
						Console.WriteLine($"Away Final: {awayFinal}");
						Console.WriteLine($"Home First Half: {homeFirst}");
						Console.WriteLine($"Away First Half: {awayFirst}");

						string insertQuery = @"
                                INSERT INTO dbo.Matches (League, HomeTeam, AwayTeam, HomeFirst, AwayFirst, HomeFinal, AwayFinal)
                                VALUES (@League, @HomeTeam, @AwayTeam, @HomeFirst, @AwayFirst, @HomeFinal, @AwayFinal)";

						using (SqlCommand command = new SqlCommand(insertQuery, connection))
						{
							command.Parameters.AddWithValue("@League", "s");
							command.Parameters.AddWithValue("@HomeTeam", homeTeam);
							command.Parameters.AddWithValue("@AwayTeam", awayTeam);
							command.Parameters.AddWithValue("@HomeFirst", homeFirst);
							command.Parameters.AddWithValue("@AwayFirst", awayFirst);
							command.Parameters.AddWithValue("@HomeFinal", homeFinal);
							command.Parameters.AddWithValue("@AwayFinal", awayFinal);

							command.ExecuteNonQuery();
						}
					}
				}
			}
			else
			{
				List<Matches> matches = new List<Matches>();
				string selectQuery = @"SELECT HomeFirst, AwayFirst, HomeFinal, AwayFinal FROM dbo.Matches";

				using (SqlConnection connection = new SqlConnection(connectionString))
				{
					connection.Open();

					using (SqlCommand command = new SqlCommand(selectQuery, connection))
					{
						using (SqlDataReader reader = command.ExecuteReader())
						{
							while (reader.Read())
							{
								Matches match = new Matches
								{
									HomeFirst = reader.GetInt32(reader.GetOrdinal("HomeFirst")),
									AwayFirst = reader.GetInt32(reader.GetOrdinal("AwayFirst")),
									HomeFinal = reader.GetInt32(reader.GetOrdinal("HomeFinal")),
									AwayFinal = reader.GetInt32(reader.GetOrdinal("AwayFinal"))
								};

								matches.Add(match);
							}
						}
					}
				}
				int firstHalfCount = 0;
				int secondHalfCount = 0;
				int equalCount = 0;

				foreach (var match in matches)
				{
					if (match.HomeFirst + match.AwayFirst > ((match.HomeFinal + match.AwayFinal) - (match.HomeFirst + match.AwayFirst)))
					{
						firstHalfCount++;
					}
					else if (match.HomeFirst + match.AwayFirst < ((match.HomeFinal + match.AwayFinal) - (match.HomeFirst + match.AwayFirst)))
					{
						secondHalfCount++;

					}
					else
					{
						equalCount++;

					}
				}

				float total = firstHalfCount + secondHalfCount + equalCount;
				float firstPerc = firstHalfCount / total  * 100;
				float secondPerc = secondHalfCount / total * 100;
				float equalPerc = equalCount / total * 100;

				Console.WriteLine($"First half: {firstHalfCount}, percentage: {firstPerc} ");
				Console.WriteLine($"Second half: {secondHalfCount}, percentage: {secondPerc}");
				Console.WriteLine($"Equal: {equalCount}, percentage: {equalPerc}");
				Console.WriteLine($"Total: {total}");
			}
		}
	}

	class Matches
	{
		public int HomeFirst { get; set; }
		public int AwayFirst { get; set; }
		public int HomeFinal { get; set; }
		public int AwayFinal { get; set;}
	}

}
