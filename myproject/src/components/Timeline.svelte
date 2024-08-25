<script>
    let events = [
      { year: 1945, event: "Vito Corleone presides over his daughter's wedding." },
      { year: 1946, event: "The Corleone family declines to enter the drug trade." },
      { year: 1947, event: "Vito Corleone is shot and wounded." },
      { year: 1950, event: "Michael Corleone becomes the head of the family." },
      { year: 1955, event: "The Corleone family relocates to Nevada." }
    ];
  </script>
  
  <section>
    <h2>Timeline</h2>
    <ul>
      {#each events as event}
        <li><strong>{event.year}:</strong> {event.event}</li>
      {/each}
    </ul>
  </section>
  
  <style>
    h2 {
      color: #f4c430;
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
  