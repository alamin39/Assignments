//
//  DataModel.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/14.
//

import Foundation


// MARK: - RepositoryInfo
struct RepositoryInfo: Codable {
    let total_count: Int
    let incomplete_results: Bool?
    let items: [ItemInfo]?
}


// MARK: - Item
struct ItemInfo: Codable {
    let id: Int?
    let node_id, name, full_name: String?
    let owner: Owner?
    let `private`: Bool?
    let html_url: String?
    let description: String?
    let fork: Bool?
    let url, forks_url, keys_url, hooks_url, issue_events_url, events_url: String?
    let assignees_url, branches_url: String?
    let tags_url, blobs_url, git_tags_url: String?
    let git_refs_url,trees_url, statuses_url,languages_url: String?
    let stargazers_url, contributors_url, subscribers_url, subscription_url: String?
    let commits_url, git_commits_url, comments_url, issue_comment_url, contents_url,compare_url: String?
    let merges_url, archive_url, downloads_url, issues_url, pulls_url: String?
    let milestones_url, notifications_url: String?
    let labels_url, releases_url, deployments_url, created_at, updated_at: String?
    let pushed_at, git_url, ssh_url, clone_url, svn_url,homepage: String?
    let size, stargazers_count, watchers_count, open_issues_count,forks_count: Int?
    let language: String?
    let has_issues, has_projects, has_downloads, has_wiki, has_pages, has_discussions, archived: Bool?
    let disabled, allow_forking, is_template, web_commit_signoff_required: Bool?
    let license: License?
    let mirror_url: String?
    let topics: [String]?
    let visibility, default_branch: String?
    let forks, open_issues, watchers: Int?
    let score: Double?
}


// MARK: - License
struct License: Codable {
    let key, name: String?
    let url, spdx_id, node_id: String?
}


// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let node_id: String?
    let avatar_url, gravatar_id: String?
    let url, received_events_url: String?
    let type, html_url, followers_url: String?
    let following_url, gists_url, starred_url: String?
    let subscriptions_url, organizations_url, repos_url, events_url: String?
    let site_admin: Bool?
}
