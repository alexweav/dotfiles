local lib = import 'gmailctl.libsonnet';

{
  version: "v1alpha3",
  author: {
    name: "Alexander Weaver",
    email: "alexander.weaver@grafana.com"
  },

  labels: [
    {
      name: "bamboo"
    },
    {
      name: "bamboo/welcome"
    },
    {
      name: "gdocs"
    },
    {
      name: "internal"
    },
    {
      name: "internal/alerting"
    },
    {
      name: "internal/all-staff"
    },
    {
      name: "internal/cloud"
    },
    {
      name: "internal/eng"
    },
    {
      name: "internal/invites"
    },
    {
      name: "github"
    },
    {
      name: "github/authored"
    },
    {
      name: "github/ci"
    },
    {
      name: "github/mention"
    },
    {
      name: "github/merged"
    },
    {
      name: "github/release"
    },
    {
      name: "github/review"
    },
    {
      name: "github/rollout"
    },
    {
      name: "github/team-prs"
    },
    {
      name: "github/team-repo"
    },
    {
      name: "newsletters"
    },
    {
      name: "hr"
    },
  ],

  rules: [
    {
      filter: {
        to: "all-staff@grafana.com"
      },
      actions: {
        markImportant: true,
        labels: ["internal/all-staff"]
      }
    },
    {
      filter: {
        or: [
          { from: "comments-noreply@docs.google.com" },
          { from: "drive-shares-dm-noreply@google.com" },
        ]
      },
      actions: {
        labels: ["gdocs"]
      }
    },
    {
      filter: {
        to: "eng@grafana.com"
      },
      actions: {
        labels: ["internal/eng"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications.github.com" },
          { query: "AND \"requested your review on\"" }
        ]
      },
      actions: {
        markImportant: true,
        labels: ["github/review"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { query: "\"@alexweav\"" }
        ]
      },
      actions: {
        labels: ["github/mention"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { query: "\"Rollout\"" }
        ]
      },
      actions: {
        markRead: true,
        labels: ["github/rollout"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@app.bamboohr.com" },
          { query: "\"Welcome\" \"to Grafana Labs\"" }
        ]
      },
      actions: {
        markRead: true,
        labels: ["bamboo/welcome"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { query: "\"Merged\" \"into main.\"" },
        ]
      },
      actions: {
        labels: ["github/merged"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { query: "\"Merged\" \"into master.\"" },
        ]
      },
      actions: {
        labels: ["github/merged"]
      }
    },

    {
        filter: {
            and: [
                { from: "notifications@github.com" },
                { query: "\"Closed\" \"as completed.\""},
            ]
        },
        actions: {
            labels: ["github/merged"]
        }
    },
    {
        filter: {
            and: [
                { from: "notifications@github.com" },
                { has: "Released by: grafanabot" },
            ]
        },
        actions: {
            labels: ["github/release"]
        }
    },
    {
      filter: {
        to: "eng@raintank.io"
      },
      actions: {
        labels: ["internal/eng"]
      }
    },
    {
      filter: {
        query: "Marriott Bonvoy"
      },
      actions: {
        category: "promotions"
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { query: "\"requested review from @grafana/alerting-squad-backend\"" }
        ]
      },
      actions: {
        labels: ["github/team-prs"]
      }
    },
    {
      filter: {
        to: "alerting@grafana.com"
      },
      actions: {
        labels: ["internal/alerting"]
      }
    },
    {
      filter: {
        to: "cloud@grafana.com"
      },
      actions: {
        labels: ["internal/cloud"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { to: "author@noreply.github.com" }
        ]
      },
      actions: {
        labels: ["github/authored"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { to: "ci_activity@noreply.github.com" }
        ]
      },
      actions: {
        markRead: true,
        labels: ["github/ci"]
      }
    },
    {
      filter: {
        and: [
          { from: "notifications@github.com" },
          { to: "review_requested@noreply.github.com" }
        ]
      },
      actions: {
        labels: ["github/team-prs"]
      }
    },
    {
      filter: {
        or: [
          { from: "mail@quastor.org" },
          { from: "kale@hackernewsletter.com" }
        ]
      },
      actions: {
        labels: ["newsletters"]
      }
    },
    {
        filter: {
            has: "invite.ics"
        },
        actions: {
            labels: ["internal/invites"]
        }
    },
    {
        filter: {
            or: [
                { from: "support@justworks.com" },
                { from: "no-reply@justworks.com" }
            ]
        },
        actions: {
            labels: ["hr"]
        }
    },
    {
        filter: {
            from: "notifications@15five.com"
        },
        actions: {
            labels: ["hr"]
        }
    },
    {
        filter: {
            from: "no-reply@greenhouse.io"
        },
        actions: {
            labels: ["hr"]
        }
    },
    {
        filter: {
            from: "concierge@expensify.com"
        },
        actions: {
            labels: ["hr"]
        }
    },
    {
        filter: {
            to: "alerting-squad@noreply.github.com"
        },
        actions: {
            labels: ["github/team-repo"]
        }
    },
  ]
}
