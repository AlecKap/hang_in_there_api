def posters_test_data
  @poster1 = Poster.create(name: "REGRET",
                          description: "Hard work rarely pays off.",
                          price: 89.00,
                          year: 2018,
                          vintage: true,
                          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                          created_at: 1.days.ago)

  @poster2 = Poster.create(name: "MOTIVATION",
                          description: "You can do it!",
                          price: 77.00,
                          year: 2017,
                          vintage: true,
                          img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                          created_at: 2.days.ago)

  @poster3 = Poster.create(name: "RESILIENCE",
                          description: "Stick with it!",
                          price: 87.00,
                          year: 2015,
                          vintage: true,
                          img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                          created_at: 3.days.ago)

  @poster4 = Poster.create(name: "SUCCESS",
                          description: "You did it!",
                          price: 98.00,
                          year: 2010,
                          vintage: true,
                          img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                          created_at: 4.days.ago)
end