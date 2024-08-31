<script>
    let characters = [
      { name: "Vito Corleone", role: "The Godfather" },
      { name: "Michael Corleone", role: "Vito's youngest son" },
      { name: "Sonny Corleone", role: "Vito's eldest son" },
      { name: "Tom Hagen", role: "The consigliere" },
      { name: "Fredo Corleone", role: "Vito's middle son" }
    ];
  </script>
  
  <section>
    <h2>Characters</h2>
    <ul>
      {#each characters as character}
        <li><strong>{character.name}:</strong> {character.role}</li>
      {/each}
    </ul>
  </section>
  
  <style>
    h2 {
      color: #f4c430;
    }
    h1:hover {
      color: #f3c848;
    }
  
    ul {
      list-style-type: none;
      padding: 0;
    }
  
    li {
      margin: 0.5rem 0;
    }
  
    strong {
      color: #f4c430;
    }
  </style>
  