const app = document.body;

const pages = document.querySelectorAll(".page");
const tabs = document.querySelectorAll(".tab");

let selectedPlayer = null;

window.addEventListener("message", function (event) {

    const data = event.data;

    if (data.action === "open") {

        app.style.display = "block";

        document.getElementById("playerName").innerText = data.player.name;
        document.getElementById("playerId").innerText = "ID : " + data.player.id;

        const list = document.getElementById("playersList");
        list.innerHTML = "";

        selectedPlayer = null;
        document.getElementById("playerActions").style.display = "none";

        if (data.players) {

            data.players.forEach((player) => {

                const div = document.createElement("div");

                div.className = "player-card";

                div.innerHTML = `
                    <div>
                        <strong>${player.name}</strong><br>
                        ID : ${player.id}
                    </div>

                    <div>
                        ${player.jobLabel}
                    </div>
                `;

                div.onclick = () => {

                    selectedPlayer = player.id;

                    document.querySelectorAll(".player-card").forEach(card => {
                        card.classList.remove("selected");
                    });

                    div.classList.add("selected");

                    document.getElementById("playerActions").style.display = "block";

                    document.getElementById("infoName").innerText = player.name;
                    document.getElementById("infoId").innerText = player.id;
                    document.getElementById("infoJob").innerText = player.jobLabel;
                    document.getElementById("infoGrade").innerText = player.grade;
                    document.getElementById("infoCash").innerText = "$" + player.cash;
                    document.getElementById("infoBank").innerText = "$" + player.bank;
                    document.getElementById("infoPing").innerText = player.ping;

                };

                list.appendChild(div);

            });

        }

    }

    if (data.action === "close") {

        app.style.display = "none";

    }

});

tabs.forEach(tab => {

    tab.addEventListener("click", () => {

        tabs.forEach(x => x.classList.remove("active"));
        pages.forEach(x => x.classList.remove("active"));

        tab.classList.add("active");

        document.getElementById(tab.dataset.tab).classList.add("active");

    });

});

document.addEventListener("keyup", function (e) {

    if (e.key === "Escape") {

        fetch(`https://${GetParentResourceName()}/close`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: "{}"
        });

    }

});

const search = document.getElementById("searchPlayer");

search.addEventListener("input", function () {

    const value = this.value.toLowerCase();

    document.querySelectorAll(".player-card").forEach(card => {

        card.style.display = card.innerText.toLowerCase().includes(value)
            ? "flex"
            : "none";

    });

});

function sendAction(action) {

    if (!selectedPlayer) {
        return;
    }

    fetch(`https://${GetParentResourceName()}/playerAction`, {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify({

            action: action,
            target: selectedPlayer

        })

    });

}

document.getElementById("gotoBtn").addEventListener("click", () => sendAction("goto"));
document.getElementById("bringBtn").addEventListener("click", () => sendAction("bring"));
document.getElementById("spectateBtn").addEventListener("click", () => sendAction("spectate"));
document.getElementById("freezeBtn").addEventListener("click", () => sendAction("freeze"));
document.getElementById("healBtn").addEventListener("click", () => sendAction("heal"));
document.getElementById("reviveBtn").addEventListener("click", () => sendAction("revive"));
document.getElementById("kickBtn").addEventListener("click", () => sendAction("kick"));