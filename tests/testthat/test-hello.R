
# scrap_one test
firms_name1 <- scrap_one(
  link = "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver",
  node = ".listing_default"
)

print(firms_name1)

# scrap_more test
firms_name2 <- scrap_more(
  "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=",
  ".listing_default",
  from = 0,
  to = 20

)

print(firms_name2)
