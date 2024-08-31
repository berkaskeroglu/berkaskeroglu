<script>
  let person = {
    name: "Michael Corleone",
    photo: '/charpics/michael-corleone.jpg',
    birthdate: "March 23, 1920",
    occupation: "Head of the Corleone family and mafia boss, former U.S. Marine Captain",
    gender: "Male",
    family: "Vito Corleone (father), Carmela Corleone (mother), Santino Corleone (brother), Frederico Corleone (brother), Tom Hagen (adopted brother), Constanzia Corleone (sister)",
    spouse: "Apollonia Vitelli (1947-48; deceased), Kay Adams (1951-5; divorced)",
    children: "Anthony Corleone, Mary Corleone",
    bio: "Michael Corleone initially wants nothing to do with his family's criminal activities, preferring an Americanized life. Vito Corleone, his father, also hopes Michael will pursue a political career. Michael drops out of Dartmouth College to enlist in the Marine Corps after Pearl Harbor, serving bravely in World War II and receiving several honors before returning home.",
    bio2: "In 1945, following an assassination attempt on his father by drug lord Virgil Sollozzo, Michael reluctantly becomes involved in the Mafia. He kills Sollozzo and corrupt NYPD captain McCluskey, sparking a Mafia war. Michael then hides in Sicily, marries Apollonia Vitelli, but loses her to a car bomb intended for him.",
    bio3: "Returning to the U.S. in 1950, Michael takes over the Corleone family, planning to legitimize their operations. He orchestrates the elimination of rival Mafia leaders and consolidates power. Despite his promise to make the family legitimate, he faces family and legal challenges, including dealing with the fallout from his order to kill Fredo.",
    bio4: "In The Godfather Part II, set in 1958-1959, Michael's efforts to legitimize the family are complicated by an assassination attempt and internal betrayals. He uncovers Fredo’s betrayal, disowns him, and ultimately has him killed. Michael also faces challenges with the Vatican and business dealings, leading to further violence and personal loss.",
    bio5: "By The Godfather Part III, set in 1979-1980, Michael has moved to New York and continues his efforts to distance the family from crime. Despite his attempts at redemption and legitimacy, he is drawn back into violence. His son Anthony’s opera debut is marred by assassination attempts, including the murder of Michael’s daughter, Mary, which devastates him. Michael dies alone in the courtyard where he married Apollonia, reflecting on his tumultuous life.",
    additionalInfo: "Other details or background information about Michael..."
  };
  let embedCode = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/ppjyB2MpxBU" title="The Godfather (3/9) Movie CLIP - Killing Sollozzo and McCluskey (1972) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description1 = "Michael kills Virgil 'The Turk' Sollozzo and the police officer McCluskey. This will cost Michael to hide in Sicily for a while. ";

  let embedCode2 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/SWAJPB_5rSs" title="The Godfather (5/9) Movie CLIP - Michael Loses Apollonia (1972) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description2 = "In Sicily, Michael meets a girl named 'Apollonia' and marries her. But a bomb that meant for Michael becomes the end of the new bride.";

  let embedCode3 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/JHtmobwu9Rg" title="Michael Becomes the new Godfather, Becomes the new Head of Family - The Godfather, 1972" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description3 = "Vito, due to his increasing health problems, chooses Michael as the new Godfather. Michael now has the full control of all the Corleone businesses. "

  let embedCode4 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/7IXVycNgGN0" title="THE GODFATHER | &quot;Don Vito and Michael Corleone&quot; Clip | Paramount Movies" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description4 = "Father and son are discussing Michael's strategy. Vito's experiences will be very helpful for Michael as he faces upcoming betrayals against the family.";

  let embedCode5 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/Rtbw8s1MJGo" title="THE GODFATHER | &quot;Moe Greene&quot; Clip | Paramount Movies" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description5 = "Michael wants to change the direction of businesses, no matter the cost.";

  let embedCode6 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/8Pf8BkFLBRw" title="The Godfather I (1972)- Baptism Scene, Michael Kills all the heads of the other families" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description6 = "As a new life begins, some will end.";
  
  let embedCode7 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/wPmTp9up26w" title="The Godfather: Part 2 (1/8) Movie CLIP - My Offer is Nothing (1974) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description7 = '"My offer, is nothing."';

  let embedCode8 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/YXfzZsdR8zc" title="The Godfather: Part II (1974) - Attack on Michael" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description8 = 'Little steps towards the new life brought new betrayals.';

  let embedCode9 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/wPmTp9up26w" title="The Godfather: Part 2 (1/8) Movie CLIP - My Offer is Nothing (1974) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description9 = '"My offer, is nothing."';

  let embedCode10 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/wPmTp9up26w" title="The Godfather: Part 2 (1/8) Movie CLIP - My Offer is Nothing (1974) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description10 = '"My offer, is nothing."';

  let embedCode11 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/wPmTp9up26w" title="The Godfather: Part 2 (1/8) Movie CLIP - My Offer is Nothing (1974) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description11 = '"My offer, is nothing."';

  let embedCode12 = `
    <iframe width="1343" height="480" src="https://www.youtube.com/embed/wPmTp9up26w" title="The Godfather: Part 2 (1/8) Movie CLIP - My Offer is Nothing (1974) HD" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  `;
  let description12 = '"My offer, is nothing."';
</script>

<style>
  h1 {
    color: #ce9f10;
  }
  h1:hover {
    color: #f4c430;
  }
  .container {
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
  }

  .main-content {
    flex: 1;
    margin-right: 20px; /* Sağ taraftaki border için yer açmak */
    border-right: 2px solid #ddd; /* Sağ kenarındaki border */
    padding-right: 20px;
  }

  .content-wrapper {
    display: flex;
    align-items: flex-start;
    margin-bottom: 10px;
  }

  .photo {
    flex: 0 0 300px;
    height: 330px;
    background-color: #ccc;
    background-size: cover;
    background-position: center;
    border-radius: 8px;
    margin-right: 20px;
  }

  .info-right {
    flex: 1;
    display: flex;
    flex-direction: column;
  }

  .info-right h1 {
    margin: 0 0 10px 0;
    font-size: 2.5rem;
  }

  .info-right p {
    margin: 5px 0;
    font-size: 1.2rem;
  }

  .info-bottom {
    border-top: 1px solid #ddd;
    margin-top: 5px;
    border-bottom: 1px solid #ddd;
  }

  .additional-info {
    margin-top: 20px;
    padding-top: 10px;
  }

  a {
    color: #ce9f10;
    text-decoration: none;
  }

  a:hover {
    text-decoration: underline;
  }

  p {
    font-family:Monaco, monospace;
  }

  .video-container {
    margin-top: 20px;
    display: flex;
    justify-content: center;
  }

  .video-container iframe {
    width: 100%;
    max-width: 800px;
    height: 450px;
  }

  .video-description {
    padding-top: 10px;
    padding-bottom: 10px;
    font-style: italic;
    border-bottom: 1px solid #ddd;
  }
</style>

<div class="container">
  <div class="content-wrapper">
    <div class="photo" style="background-image: url({person.photo});" alt="Michael Corleone"></div>
    <div class="info-right">
      <h1>{person.name}</h1>
      <p><strong>Birthdate:</strong> {person.birthdate}</p>
      <p><strong>Occupation:</strong> {person.occupation}</p>
      <p><strong>Family:</strong> {person.family}</p>
      <p><strong>Spouse:</strong> {person.spouse}</p>
      <p><strong>Children:</strong> {person.children}</p>
    </div>
  </div>
  <div class="info-bottom">
    <p class="bio">{@html person.bio}</p>
    <p class="bio">{@html person.bio2}</p>
    <p class="bio">{@html person.bio3}</p>
    <p class="bio">{@html person.bio4}</p>
    <p class="bio">{@html person.bio5}</p>
  </div>
  <div class="video-container" >{@html embedCode}</div>
  <div class ="video-description">{@html description1}</div>
  <div class="video-container" >{@html embedCode2}</div>
  <div class ="video-description">{@html description2}</div>
  <div class="video-container" >{@html embedCode3}</div>
  <div class ="video-description">{@html description3}</div>
  <div class="video-container" >{@html embedCode4}</div>
  <div class ="video-description">{@html description4}</div>
  <div class="video-container" >{@html embedCode5}</div>
  <div class ="video-description">{@html description5}</div>
  <div class="video-container" >{@html embedCode6}</div>
  <div class ="video-description">{@html description6}</div>
  <div class="video-container" >{@html embedCode7}</div>
  <div class ="video-description">{@html description7}</div>
  <div class="video-container" >{@html embedCode8}</div>
  <div class ="video-description">{@html description8}</div>

</div>
